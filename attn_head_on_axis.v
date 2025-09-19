`timescale 1ps / 1ps

module attn_head_on_axis
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer LAYERS        = 12,
    parameter integer M1            = 4,
    parameter integer M2            = 4,
    parameter integer M3            = 4,
    parameter integer BLOCKS        = 4,
    parameter integer N1            = 4,
    parameter integer N2            = 4,
    parameter integer sN1           = 4,
    parameter integer sN2           = 4,
    parameter integer MATRIXSIZE_W  = 24,
    parameter integer KEEP_A        = 1
)
(
    input wire clk,
    input wire fclk,
    input wire rst_n,
    // incoming intermediate stream
    input  wire signed [31:0]    in_x_TDATA,
    input  wire                  in_x_TVALID,
    output wire                  in_x_TREADY,
    input  wire                  in_x_TLAST,
	// incoming stream
    input  wire signed [31:0]    x_TDATA,
    input  wire                  x_TVALID,
    output wire                  x_TREADY,
    input  wire                  x_TLAST,
    output wire                  x_RCVD,
    // outgoing intermediate stream
    `ifdef ONESYS
    `ifdef PING_PONG
    `ifdef READ_A
    input  wire signed [D_W-1:0] out_R_TDATA,
    input  wire                  out_R_TVALID,
    output wire                  out_R_TREADY,
    input  wire                  out_R_TLAST,
    `endif
    `endif
    `endif
	// outgoing stream
    output wire signed [31:0]    y_TDATA,
    output wire                  y_TVALID,
    input  wire                  y_TREADY,
    output wire                  y_TLAST,
    // params
    input  wire [$clog2(LAYERS)-1:0] layer
);

localparam [MATRIXSIZE_W-1:0] M1xM2 = M1*M2;
localparam [MATRIXSIZE_W-1:0] M2xM3 = M2*M3;
localparam [MATRIXSIZE_W-1:0] M1xM3dN1 = M1*M3/N1;
localparam [MATRIXSIZE_W-1:0] M1dN1 = M1/N1;
localparam [MATRIXSIZE_W-1:0] M3dN2 = M3/N2;
localparam [MATRIXSIZE_W-1:0] M1xM3dN1xN2 = M1*M3/(N1*N2);
localparam [MATRIXSIZE_W-1:0] M1xM1dN1 = M1*M1/N1;
localparam [MATRIXSIZE_W-1:0] M1xM1dN1xN1 = M1*M1/(N1*N1);

localparam [MATRIXSIZE_W-1:0] BLOCK_WIDTH = M3/BLOCKS;
localparam [MATRIXSIZE_W-1:0] BLOCK_WIDTHdN2 = (M3/BLOCKS)/N2;
localparam [MATRIXSIZE_W-1:0] BLOCK_SIZEdN2 = (M2*(M3/BLOCKS))/N2;
localparam [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1xN2 = M1*(M3/BLOCKS)/(N1*N2);
localparam [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1 = M1*(M3/BLOCKS)/N1;

localparam integer SOFTMAX_N = M1;
localparam integer MEM_DEPTH_A = (M1*M2)/N1;
localparam integer MEM_DEPTH_B = (M2*(M3/BLOCKS))/N2;
localparam integer MEM_DEPTH_D = (M1*M3)/N1;
localparam integer MEM_DEPTH_Q = (M1*M3)/sN1;
localparam integer MEM_DEPTH_K = (M1*M3)/sN2;
localparam integer MEM_DEPTH_S = (M1*M1)/sN1;
localparam integer REQ_MEM_DEPTH = M3;

localparam integer NUM_IN = 14;

reg signed [31:0] in_TDATA;
wire signed [D_W-1:0] out_TDATA;

localparam [3:0]
    IDLE           = 4'd0,
    STATE_W_Q      = 4'd1,
    STATE_bias_Q   = 4'd2,
    STATE_m_Q      = 4'd3,
    STATE_e_Q      = 4'd4,
    STATE_W_K      = 4'd5,
    STATE_bias_K   = 4'd6,
    STATE_m_K      = 4'd7,
    STATE_e_K      = 4'd8,
    STATE_W_V      = 4'd9,
    STATE_bias_V   = 4'd10,
    STATE_m_V      = 4'd11,
    STATE_e_V      = 4'd12,
    STATE_m_C      = 4'd13,
    STATE_e_C      = 4'd14;

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
    states[5]  <= 0;
    states[6]  <= 0;
    states[7]  <= 0;
    states[8]  <= 0;
    states[9]  <= 0;
    states[10] <= 0;
    states[11] <= 0;
    states[12] <= 0;
    states[13] <= 0;
    states[14] <= 0;
  end else begin
    states[0]  <= STATE_W_Q;
    states[1]  <= STATE_bias_Q;
    states[2]  <= STATE_m_Q;
    states[3]  <= STATE_e_Q;
    states[4]  <= STATE_W_K;
    states[5]  <= STATE_bias_K;
    states[6]  <= STATE_m_K;
    states[7]  <= STATE_e_K;
    states[8]  <= STATE_W_V;
    states[9]  <= STATE_bias_V;
    states[10] <= STATE_m_V;
    states[11] <= STATE_e_V;
    states[12] <= STATE_m_C;
    states[13] <= STATE_e_C;
    states[14] <= STATE_W_Q;
  end
end

always @(posedge clk) begin
  if(~rst_n) begin
    rdaddr_lengths[0]  <= 0;
    rdaddr_lengths[1]  <= 0;
    rdaddr_lengths[2]  <= 0;
    rdaddr_lengths[3]  <= 0;
    rdaddr_lengths[4]  <= 0;
    rdaddr_lengths[5]  <= 0;
    rdaddr_lengths[6]  <= 0;
    rdaddr_lengths[7]  <= 0;
    rdaddr_lengths[8]  <= 0;
    rdaddr_lengths[9]  <= 0;
    rdaddr_lengths[10] <= 0;
    rdaddr_lengths[11] <= 0;
    rdaddr_lengths[12] <= 0;
    rdaddr_lengths[13] <= 0;
    rdaddr_lengths[14] <= 0;
  end else begin
    rdaddr_lengths[0]  <= 123;
    rdaddr_lengths[1]  <= M2xM3;
    rdaddr_lengths[2]  <= M3;
    rdaddr_lengths[3]  <= M3;
    rdaddr_lengths[4]  <= M3;
    rdaddr_lengths[5]  <= M2xM3;
    rdaddr_lengths[6]  <= M3;
    rdaddr_lengths[7]  <= M3;
    rdaddr_lengths[8]  <= M3;
    rdaddr_lengths[9]  <= M2xM3;
    rdaddr_lengths[10] <= M3;
    rdaddr_lengths[11] <= M3;
    rdaddr_lengths[12] <= M3;
    rdaddr_lengths[13] <= 1;
    rdaddr_lengths[14] <= 1;
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

attn_head_wrap #(
    .D_W           (D_W),
    .D_W_ACC       (D_W_ACC),
    .N1            (N1),
    .N2            (N2),
    .sN1           (sN1),
    .sN2           (sN2),
    .SOFTMAX_N     (SOFTMAX_N),
    .MATRIXSIZE_W  (MATRIXSIZE_W),
    .KEEP_A        (KEEP_A),
    .MEM_DEPTH_A   (MEM_DEPTH_A),
    .MEM_DEPTH_B   (MEM_DEPTH_B),
    .MEM_DEPTH_D   (MEM_DEPTH_D),
    .MEM_DEPTH_Q   (MEM_DEPTH_Q),
    .MEM_DEPTH_K   (MEM_DEPTH_K),
    .MEM_DEPTH_S   (MEM_DEPTH_S),
    .REQ_MEM_DEPTH (REQ_MEM_DEPTH)
)
attn_head_wrap_inst (
    .clk(clk),
    .fclk(fclk),
    .rst(~rst_n),
    .layer(layer),

    .s_axis_s2mm_tdata_I(in_x_TDATA),
    .s_axis_s2mm_tlast_I(in_x_TLAST),
    .s_axis_s2mm_tready_I(in_x_TREADY),
    .s_axis_s2mm_tvalid_I(in_x_TVALID),

    .s_axis_s2mm_tdata_W_Q(in_TDATA),
    .s_axis_s2mm_tlast_W_Q(in_tlast_signals_r[1]),
    .s_axis_s2mm_tready_W_Q(in_tready_signals_r[1]),
    .s_axis_s2mm_tvalid_W_Q(in_tvalid_signals_r[1]),

    .s_axis_s2mm_tdata_bias_Q(in_TDATA),
    .s_axis_s2mm_tlast_bias_Q(in_tlast_signals_r[2]),
    .s_axis_s2mm_tready_bias_Q(in_tready_signals_r[2]),
    .s_axis_s2mm_tvalid_bias_Q(in_tvalid_signals_r[2]),

    .s_axis_s2mm_tdata_m_Q(in_TDATA),
    .s_axis_s2mm_tlast_m_Q(in_tlast_signals_r[3]),
    .s_axis_s2mm_tready_m_Q(in_tready_signals_r[3]),
    .s_axis_s2mm_tvalid_m_Q(in_tvalid_signals_r[3]),

    .s_axis_s2mm_tdata_e_Q(in_TDATA),
    .s_axis_s2mm_tlast_e_Q(in_tlast_signals_r[4]),
    .s_axis_s2mm_tready_e_Q(in_tready_signals_r[4]),
    .s_axis_s2mm_tvalid_e_Q(in_tvalid_signals_r[4]),

    .s_axis_s2mm_tdata_W_K(in_TDATA),
    .s_axis_s2mm_tlast_W_K(in_tlast_signals_r[5]),
    .s_axis_s2mm_tready_W_K(in_tready_signals_r[5]),
    .s_axis_s2mm_tvalid_W_K(in_tvalid_signals_r[5]),

    .s_axis_s2mm_tdata_bias_K(in_TDATA),
    .s_axis_s2mm_tlast_bias_K(in_tlast_signals_r[6]),
    .s_axis_s2mm_tready_bias_K(in_tready_signals_r[6]),
    .s_axis_s2mm_tvalid_bias_K(in_tvalid_signals_r[6]),

    .s_axis_s2mm_tdata_m_K(in_TDATA),
    .s_axis_s2mm_tlast_m_K(in_tlast_signals_r[7]),
    .s_axis_s2mm_tready_m_K(in_tready_signals_r[7]),
    .s_axis_s2mm_tvalid_m_K(in_tvalid_signals_r[7]),

    .s_axis_s2mm_tdata_e_K(in_TDATA),
    .s_axis_s2mm_tlast_e_K(in_tlast_signals_r[8]),
    .s_axis_s2mm_tready_e_K(in_tready_signals_r[8]),
    .s_axis_s2mm_tvalid_e_K(in_tvalid_signals_r[8]),

    .s_axis_s2mm_tdata_W_V(in_TDATA),
    .s_axis_s2mm_tlast_W_V(in_tlast_signals_r[9]),
    .s_axis_s2mm_tready_W_V(in_tready_signals_r[9]),
    .s_axis_s2mm_tvalid_W_V(in_tvalid_signals_r[9]),

    .s_axis_s2mm_tdata_bias_V(in_TDATA),
    .s_axis_s2mm_tlast_bias_V(in_tlast_signals_r[10]),
    .s_axis_s2mm_tready_bias_V(in_tready_signals_r[10]),
    .s_axis_s2mm_tvalid_bias_V(in_tvalid_signals_r[10]),

    .s_axis_s2mm_tdata_m_V(in_TDATA),
    .s_axis_s2mm_tlast_m_V(in_tlast_signals_r[11]),
    .s_axis_s2mm_tready_m_V(in_tready_signals_r[11]),
    .s_axis_s2mm_tvalid_m_V(in_tvalid_signals_r[11]),

    .s_axis_s2mm_tdata_e_V(in_TDATA),
    .s_axis_s2mm_tlast_e_V(in_tlast_signals_r[12]),
    .s_axis_s2mm_tready_e_V(in_tready_signals_r[12]),
    .s_axis_s2mm_tvalid_e_V(in_tvalid_signals_r[12]),

    .s_axis_s2mm_tdata_m_C(in_TDATA),
    .s_axis_s2mm_tlast_m_C(in_tlast_signals_r[13]),
    .s_axis_s2mm_tready_m_C(in_tready_signals_r[13]),
    .s_axis_s2mm_tvalid_m_C(in_tvalid_signals_r[13]),

    .s_axis_s2mm_tdata_e_C(in_TDATA),
    .s_axis_s2mm_tlast_e_C(in_tlast_signals_r[14]),
    .s_axis_s2mm_tready_e_C(in_tready_signals_r[14]),
    .s_axis_s2mm_tvalid_e_C(in_tvalid_signals_r[14]),

    `ifdef ONESYS
    `ifdef PING_PONG
    `ifdef READ_A
    .m_axis_mm2s_tdata_I(out_R_TDATA),
    .m_axis_mm2s_tlast_I(out_R_TLAST),
    .m_axis_mm2s_tready_I(out_R_TREADY),
    .m_axis_mm2s_tvalid_I(out_R_TVALID),
    `endif
    `endif
    `endif

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
    .M1xM1dN1(M1xM1dN1),
    .M1xM1dN1xN1(M1xM1dN1xN1),

    .BLOCKS(BLOCKS),
    .BLOCK_WIDTH(BLOCK_WIDTH),
    .BLOCK_WIDTHdN2(BLOCK_WIDTHdN2),
    .BLOCK_SIZEdN2(BLOCK_SIZEdN2),
    .M1xBLOCK_WIDTHdN1xN2(M1xBLOCK_WIDTHdN1xN2),
    .M1xBLOCK_WIDTHdN1(M1xBLOCK_WIDTHdN1)
);

endmodule
