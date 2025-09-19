
`timescale 1ps / 1ps

module mm_gelu_on_axis
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer LAYERS        = 12,
    parameter integer M1            = 4,
    parameter integer M2            = 4,
    parameter integer M3            = 4,
    parameter integer BLOCKS        = 4,
    parameter         BLOCKED_D     = 0,
    parameter integer N1            = 4,
    parameter integer N2            = 4,
    parameter integer MATRIXSIZE_W  = 16
)
(
    input wire clk,
    input wire fclk,
    input wire rst_n,
    // incoming intermediate stream
    input  wire signed [31:0] in_x_TDATA,
    input  wire               in_x_TVALID,
    output wire               in_x_TREADY,
    input  wire               in_x_TLAST,
	// incoming stream
    input  wire signed [31:0] x_TDATA,
    input  wire               x_TVALID,
    output wire               x_TREADY,
    input  wire               x_TLAST,
    output wire               x_RCVD,
	// outgoing stream
    output wire signed [31:0] y_TDATA,
    output wire               y_TVALID,
    input  wire               y_TREADY,
    output wire               y_TLAST,
    // params
    input  wire [$clog2(LAYERS)-1:0] layer
);

localparam [MATRIXSIZE_W-1:0] M1xM2 = M1*M2;
localparam [MATRIXSIZE_W-1:0] M2xM3 = M2*M3;
localparam [MATRIXSIZE_W-1:0] M1xM3dN1 = M1*M3/N1;
localparam [MATRIXSIZE_W-1:0] M1dN1 = M1/N1;
localparam [MATRIXSIZE_W-1:0] M3dN2 = M3/N2;
localparam [MATRIXSIZE_W-1:0] M1xM3dN1xN2 = M1*M3/(N1*N2);

localparam [MATRIXSIZE_W-1:0] BLOCK_WIDTH = M3/BLOCKS;
localparam [MATRIXSIZE_W-1:0] BLOCK_WIDTHdN2 = (M3/BLOCKS)/N2;
localparam [MATRIXSIZE_W-1:0] BLOCK_SIZEdN2 = (M2*(M3/BLOCKS))/N2;
localparam [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1xN2 = M1*(M3/BLOCKS)/(N1*N2);
localparam [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1 = M1*(M3/BLOCKS)/N1;

localparam integer MEM_DEPTH_A = (M1*M2)/N1;
localparam integer MEM_DEPTH_B = (M2*(M3/BLOCKS))/N2;
localparam integer MEM_DEPTH_D = BLOCKED_D ? (M1*(M3/BLOCKS))/N1 : (M1*M3)/N1;
localparam integer REQ_MEM_DEPTH = M3;

localparam integer NUM_IN = 4;

reg signed [31:0] in_TDATA;
wire signed [D_W-1:0] out_TDATA;

localparam [3:0]
    IDLE           = 4'd0,
    STATE_W_bias   = 4'd1,
    STATE_out_m    = 4'd2,
    STATE_out_e    = 4'd3,
    STATE_W        = 4'd4;

reg [3:0] curr_state = IDLE;
reg [3:0] next_state;

reg [3:0] states[0:NUM_IN];
reg [MATRIXSIZE_W-1:0] rdaddr_lengths[0:NUM_IN];
reg [MATRIXSIZE_W-1:0] rdaddr_signals[0:NUM_IN];

reg [NUM_IN:0] in_tvalid_signals;
reg [NUM_IN:0] in_tlast_signals;
reg [NUM_IN:0] in_tready_signals;

reg  [NUM_IN:0] in_tvalid_signals_r = 0;
reg  [NUM_IN:0] in_tlast_signals_r = 0;
wire [NUM_IN:0] in_tready_signals_r;

assign y_TDATA = out_TDATA;
assign x_RCVD = in_tvalid_signals[NUM_IN] & in_tlast_signals[NUM_IN] & in_tready_signals[NUM_IN];
assign x_TREADY = in_tready_signals[curr_state];

assign in_tready_signals_r[0] = 0;  // IDLE

always @(posedge clk) begin
  if(~rst_n) begin
    states[0]  <= 0;
    states[1]  <= 0;
    states[2]  <= 0;
    states[3]  <= 0;
    states[4]  <= 0;
  end else begin
    states[0]  <= STATE_W_bias;
    states[1]  <= STATE_out_m;
    states[2]  <= STATE_out_e;
    states[3]  <= STATE_W;
    states[4]  <= STATE_W_bias;
  end
end

always @(posedge clk) begin
  if(~rst_n) begin
    rdaddr_lengths[0]  <= 0;
    rdaddr_lengths[1]  <= 0;
    rdaddr_lengths[2]  <= 0;
    rdaddr_lengths[3]  <= 0;
    rdaddr_lengths[4]  <= 0;
  end else begin
    rdaddr_lengths[0]  <= 123;
    rdaddr_lengths[1]  <= M3;
    rdaddr_lengths[2]  <= 1;
    rdaddr_lengths[3]  <= 1;
    rdaddr_lengths[4]  <= M2xM3;
  end
end

always @(posedge clk) begin
    if (~rst_n) begin
        curr_state <= IDLE;
    end else begin
        curr_state <= next_state;
    end
end

always @(*) begin
    if (curr_state == IDLE) begin
        next_state = states[curr_state];
    end else begin
        if (in_tvalid_signals[curr_state] & in_tlast_signals[curr_state] & in_tready_signals[curr_state]) begin
            next_state = states[curr_state];
        end else begin
            next_state = curr_state;
        end
    end
end

integer x;
always @(*) begin
    in_tready_signals[0] = 0;   // IDLE
    for (x = 1; x <= NUM_IN; x = x + 1) begin
        in_tready_signals[x] = in_tready_signals_r[x] & (curr_state == x);
    end
end

always @(*) begin
    in_tvalid_signals[0] = 0;   // IDLE
    for (x = 1; x <= NUM_IN; x = x + 1) begin
        in_tvalid_signals[x] = x_TVALID & (curr_state == x);
    end
end

always @(*) begin
    in_tlast_signals[0] = 0;    // IDLE
    for (x = 1; x <= NUM_IN; x = x + 1) begin
        in_tlast_signals[x] = in_tvalid_signals[x] & (rdaddr_signals[x] == rdaddr_lengths[x] - 1);
    end
end

always @(posedge clk) begin
    if (~rst_n) begin
        for (x = 0; x <= NUM_IN; x = x + 1) begin
            rdaddr_signals[x] <= 0;
        end
    end else begin
        for (x = 1; x <= NUM_IN; x = x + 1) begin
            if (in_tvalid_signals[x] & in_tready_signals[x]) begin
                rdaddr_signals[x] <= in_tlast_signals[x] ? 0 : rdaddr_signals[x] + 1;
            end
        end
    end
end

always @(posedge clk) begin
    if (~rst_n) begin
        in_tvalid_signals_r <= 0;
        in_tlast_signals_r <= 0;
    end else begin
        for (x = 1; x <= NUM_IN; x = x + 1) begin
            if (in_tready_signals_r[x]) begin
                in_tvalid_signals_r[x] <= in_tvalid_signals[x];
                in_tlast_signals_r[x] <= in_tlast_signals[x];
            end
        end
    end
end

always @(posedge clk) begin
    if (~rst_n) begin
        in_TDATA <= 0;
    end else begin
        if (x_TREADY) begin
            in_TDATA <= x_TDATA;
        end
    end
end

mm_gelu_wrap #(
    .D_W(D_W),
    .D_W_ACC(D_W_ACC),
    .LAYERS(LAYERS),
    .N1(N1),
    .N2(N2),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .BLOCKED_D(BLOCKED_D),
    .MEM_DEPTH_A(MEM_DEPTH_A),
    .MEM_DEPTH_B(MEM_DEPTH_B),
    .MEM_DEPTH_D(MEM_DEPTH_D),
    .REQ_MEM_DEPTH(REQ_MEM_DEPTH)
)
mm_gelu_wrap_inst (
    .clk(clk),
    .fclk(fclk),
    .rst(~rst_n),
    .layer(layer),

    .s_axis_s2mm_tdata_A(in_x_TDATA),
    .s_axis_s2mm_tlast_A(in_x_TLAST),
    .s_axis_s2mm_tready_A(in_x_TREADY),
    .s_axis_s2mm_tvalid_A(in_x_TVALID),

    .s_axis_s2mm_tdata_W_bias(in_TDATA),
    .s_axis_s2mm_tlast_W_bias(in_tlast_signals_r[1]),
    .s_axis_s2mm_tready_W_bias(in_tready_signals_r[1]),
    .s_axis_s2mm_tvalid_W_bias(in_tvalid_signals_r[1]),

    .s_axis_s2mm_tdata_out_m(in_TDATA),
    .s_axis_s2mm_tlast_out_m(in_tlast_signals_r[2]),
    .s_axis_s2mm_tready_out_m(in_tready_signals_r[2]),
    .s_axis_s2mm_tvalid_out_m(in_tvalid_signals_r[2]),
    
    .s_axis_s2mm_tdata_out_e(in_TDATA),
    .s_axis_s2mm_tlast_out_e(in_tlast_signals_r[3]),
    .s_axis_s2mm_tready_out_e(in_tready_signals_r[3]),
    .s_axis_s2mm_tvalid_out_e(in_tvalid_signals_r[3]),

    .s_axis_s2mm_tdata_W(in_TDATA),
    .s_axis_s2mm_tlast_W(in_tlast_signals_r[4]),
    .s_axis_s2mm_tready_W(in_tready_signals_r[4]),
    .s_axis_s2mm_tvalid_W(in_tvalid_signals_r[4]),

    .out_tdata(out_TDATA),
    .out_tlast(y_TLAST),
    .out_tready(y_TREADY),
    .out_tvalid(y_TVALID),

    .M1(M1),
    .M2(M2),
    .M3(M3),
    .M1xM3dN1(M1xM3dN1),
    .M1dN1(M1dN1),
    .M3dN2(M3dN2),
    .M1xM3dN1xN2(M1xM3dN1xN2),

    .BLOCKS(BLOCKS),
    .BLOCK_WIDTH(BLOCK_WIDTH),
    .BLOCK_WIDTHdN2(BLOCK_WIDTHdN2),
    .BLOCK_SIZEdN2(BLOCK_SIZEdN2),
    .M1xBLOCK_WIDTHdN1xN2(M1xBLOCK_WIDTHdN1xN2),
    .M1xBLOCK_WIDTHdN1(M1xBLOCK_WIDTHdN1)
);

endmodule
