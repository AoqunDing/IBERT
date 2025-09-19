
`timescale 1ps / 1ps

module ibert_axi
#(
    parameter integer D_W          = 8,
    parameter integer D_W_ACC      = 32,
    parameter integer N1_HEAD      = 8,
    parameter integer N2_HEAD      = 8,
    parameter integer sN1_HEAD     = 4,
    parameter integer sN2_HEAD     = 4,
    parameter integer N1_SELF      = 4,
    parameter integer N2_SELF      = 4,
    parameter integer N1_INTER     = 4,
    parameter integer N2_INTER     = 4,
    parameter integer N1_LAYER     = 4,
    parameter integer N2_LAYER     = 4,
    parameter integer MATRIXSIZE_W = 24,
    parameter integer LAYERS       = 12,
    parameter integer HEADS        = 12,
    parameter integer TOKENS       = 32,
    parameter integer EMBED_SIZE   = 768,
    parameter integer INTER_SIZE   = 3072,
    parameter integer BLOCKS_HEAD  = 8,
    parameter integer BLOCKS_SELF  = 192,
    parameter integer BLOCKS_INTER = 768,
    parameter integer BLOCKS_LAYER = 192,
    parameter         BLOCKED_D    = 0,
    parameter integer KEEP_A       = 12,
    parameter integer SLICES       = 8,
    parameter integer LN_BITS      = 22
)
(
    input wire clk,
    input wire fclk,
    input wire rst_n,
	// incoming stream
    input  wire signed [31:0] x_TDATA,
    input  wire               x_TVALID,
    input  wire               x_TLAST,
    output reg                x_TREADY,
	// outgoing stream
    output reg  signed [31:0] y_TDATA,
    output reg                y_TVALID,
    output reg                y_TLAST,
    input  wire               y_TREADY
);

localparam integer HEAD_SIZE = EMBED_SIZE/HEADS;
localparam integer M1_HEAD = TOKENS;
localparam integer M2_HEAD = EMBED_SIZE;
localparam integer M3_HEAD = HEAD_SIZE;

localparam integer M1_SELF = TOKENS/SLICES;
localparam integer M2_SELF = EMBED_SIZE;
localparam integer M3_SELF = EMBED_SIZE;

localparam integer M1_INTER = TOKENS/SLICES;
localparam integer M2_INTER = EMBED_SIZE;
localparam integer M3_INTER = INTER_SIZE;

localparam integer M1_LAYER = TOKENS/SLICES;
localparam integer M2_LAYER = INTER_SIZE;
localparam integer M3_LAYER = EMBED_SIZE;

localparam [MATRIXSIZE_W-1:0] M1xM2_I = TOKENS*EMBED_SIZE;

wire signed [31:0] x_TDATA_I;
wire               x_TVALID_I;
wire               x_TLAST_I;
wire               x_TREADY_I_HEAD, x_TREADY_I_SELF;
wire               x_RCVD_I;

wire signed [31:0] x_TDATA_HEAD;
wire               x_TVALID_HEAD;
wire               x_TLAST_HEAD;
wire               x_TREADY_HEAD;
wire               x_RCVD_HEAD;

wire signed [31:0] y_TDATA_HEAD;
wire               y_TVALID_HEAD;
wire               y_TLAST_HEAD;
wire               y_TREADY_HEAD;

wire signed [31:0] x_TDATA_SELF;
wire               x_TVALID_SELF;
wire               x_TLAST_SELF;
wire               x_TREADY_SELF;
wire               x_RCVD_SELF;

wire signed [31:0] y_TDATA_SELF;
wire               y_TVALID_SELF;
wire               y_TLAST_SELF;
wire               y_TREADY_SELF_INTER, y_TREADY_SELF_LAYER;

wire signed [31:0] x_TDATA_INTER;
wire               x_TVALID_INTER;
wire               x_TLAST_INTER;
wire               x_TREADY_INTER;
wire               x_RCVD_INTER;

wire signed [31:0] y_TDATA_INTER;
wire               y_TVALID_INTER;
wire               y_TLAST_INTER;
wire               y_TREADY_INTER;

wire signed [31:0] x_TDATA_LAYER;
wire               x_TVALID_LAYER;
wire               x_TLAST_LAYER;
wire               x_TREADY_LAYER;
wire               x_RCVD_LAYER;

wire signed [31:0] y_TDATA_LAYER;
wire               y_TVALID_LAYER;
wire               y_TLAST_LAYER;
wire               y_TREADY_LAYER;

reg [MATRIXSIZE_W-1:0] rdaddr_I = 0;
reg [$clog2(HEADS):0]  head_in_cntr = 0;
reg [$clog2(HEADS):0]  head_out_cntr = 0;
reg [$clog2(SLICES):0] slice_in_cntr = 0;
reg [$clog2(SLICES):0] slice_out_cntr = 0;
reg [$clog2(LAYERS)-1:0] layer_cntr = 0;
reg [3:0] module_in_id = 0;
reg [3:0] module_out_id = 0;

always @(posedge clk) begin
    if (~rst_n) begin
        rdaddr_I <= 0;
    end else begin
        if ((module_in_id == 1'd1) & x_TVALID & x_TREADY) begin
            rdaddr_I <= (rdaddr_I == M1xM2_I - 1) ? 0 : rdaddr_I + 1;
        end
    end
end

always @(*) begin
    case (module_in_id)
        4'd1: x_TREADY = x_TREADY_I_HEAD & x_TREADY_I_SELF;
        4'd2: x_TREADY = x_TREADY_HEAD;
        4'd3: x_TREADY = x_TREADY_SELF;
        4'd4: x_TREADY = x_TREADY_INTER;
        4'd5: x_TREADY = x_TREADY_LAYER;
        default: x_TREADY = 0;
    endcase
end

always @(*) begin
    case (module_out_id)
        4'd1: begin
            y_TDATA = y_TDATA_HEAD;
            y_TVALID = y_TVALID_HEAD & y_TREADY_HEAD;
            y_TLAST = (head_out_cntr == HEADS-1) & y_TLAST_HEAD & y_TREADY_HEAD;
        end
        4'd4: begin
            y_TDATA = y_TDATA_LAYER;
            y_TVALID = y_TVALID_LAYER & x_TREADY_I_HEAD & x_TREADY_I_SELF;
            y_TLAST = (slice_out_cntr == SLICES-1) & y_TLAST_LAYER & x_TREADY_I_HEAD & x_TREADY_I_SELF;
        end
        default: begin
            y_TDATA = 0;
            y_TVALID = 0;
            y_TLAST = 0;
        end
    endcase
end

assign x_TDATA_I      = (module_in_id == 4'd1) ? x_TDATA : y_TDATA_LAYER;
assign x_RCVD_I       = (module_in_id == 4'd1) & x_TVALID & x_TREADY & (rdaddr_I == M1xM2_I - 1);

assign x_TVALID_I     = (module_in_id == 4'd1) ? x_TVALID : y_TVALID_LAYER;
assign x_TVALID_HEAD  = (module_in_id == 4'd2) & x_TVALID;
assign x_TVALID_SELF  = (module_in_id == 4'd3) & x_TVALID;
assign x_TVALID_INTER = (module_in_id == 4'd4) & x_TVALID;
assign x_TVALID_LAYER = (module_in_id == 4'd5) & x_TVALID;

assign x_TLAST_I     = (module_in_id == 4'd1) ? x_RCVD_I : (slice_out_cntr == SLICES-1) & y_TLAST_LAYER;
assign x_TLAST_HEAD  = (module_in_id == 4'd2) & x_TLAST;
assign x_TLAST_SELF  = (module_in_id == 4'd3) & x_TLAST;
assign x_TLAST_INTER = (module_in_id == 4'd4) & x_TLAST;
assign x_TLAST_LAYER = (module_in_id == 4'd5) & x_TLAST;

always @(posedge clk) begin
    if (~rst_n) begin
        head_out_cntr <= 0;
        slice_out_cntr <= 0;
        layer_cntr <= 0;
        module_out_id <= 4'd0;
    end else begin
        if (module_out_id == 4'd0) begin
            module_out_id <= 4'd1;
        end else if ((module_out_id == 4'd1) && y_TVALID_HEAD & y_TLAST_HEAD & y_TREADY) begin
            head_out_cntr <= head_out_cntr + 1;
            if (head_out_cntr == HEADS-1) begin
                head_out_cntr <= 0;
                module_out_id <= 4'd4;
            end
        end else if ((module_out_id == 4'd4) && y_TVALID_LAYER & y_TLAST_LAYER & y_TREADY) begin
            slice_out_cntr <= slice_out_cntr + 1;
            if (slice_out_cntr == SLICES-1) begin
                slice_out_cntr <= 0;
                module_out_id <= 4'd1;
                layer_cntr <= layer_cntr + 1;
                if (layer_cntr == LAYERS-1) begin
                    layer_cntr <= 0;
                end
            end
        end
    end
end

always @(posedge clk) begin
    if (~rst_n) begin
        head_in_cntr <= 0;
        slice_in_cntr <= 0;
        module_in_id <= 4'd0;
    end else begin
        if (module_in_id == 4'd0) begin
            module_in_id <= 4'd1;
        end else if ((module_in_id == 4'd1) && x_RCVD_I) begin
            module_in_id <= 4'd2;
        end else if ((module_in_id == 4'd2) && x_RCVD_HEAD) begin
            head_in_cntr <= head_in_cntr + 1;
            if (head_in_cntr == HEADS-1) begin
                head_in_cntr <= 0;
                module_in_id <= 4'd3;
            end
        end else if ((module_in_id == 4'd3) && x_RCVD_SELF) begin
            module_in_id <= 4'd4;
        end else if ((module_in_id == 4'd4) && x_RCVD_INTER) begin
            module_in_id <= 4'd5;
        end else if ((module_in_id == 4'd5) && x_RCVD_LAYER) begin
            module_in_id <= 4'd3;
            slice_in_cntr <= slice_in_cntr + 1;
            if (slice_in_cntr == SLICES-1) begin
                slice_in_cntr <= 0;
                module_in_id <= 4'd2;
            end
        end
    end
end

attn_head_on_axis
#(
    .D_W           (D_W),
    .D_W_ACC       (D_W_ACC),
    .LAYERS        (LAYERS),
    .M1            (M1_HEAD),
    .M2            (M2_HEAD),
    .M3            (M3_HEAD),
    .BLOCKS        (BLOCKS_HEAD),
    .N1            (N1_HEAD),
    .N2            (N2_HEAD),
    .sN1           (sN1_HEAD),
    .sN2           (sN2_HEAD),
    .MATRIXSIZE_W  (MATRIXSIZE_W),
    .KEEP_A        (KEEP_A)
)
attn_head_axis_inst (
    .clk         (clk),
    .fclk        (clk),
    .rst_n       (rst_n),
    
    .in_x_TDATA  (x_TDATA_I),
    .in_x_TVALID (x_TVALID_I & x_TREADY_I_SELF & y_TREADY),
    .in_x_TLAST  (x_TLAST_I & x_TREADY_I_SELF & y_TREADY),
    .in_x_TREADY (x_TREADY_I_HEAD),

    .x_TDATA     (x_TDATA),
    .x_TVALID    (x_TVALID_HEAD),
    .x_TLAST     (x_TLAST_HEAD),
    .x_TREADY    (x_TREADY_HEAD),
    .x_RCVD      (x_RCVD_HEAD),

    .y_TDATA     (y_TDATA_HEAD),
    .y_TVALID    (y_TVALID_HEAD),
    .y_TLAST     (y_TLAST_HEAD),
    .y_TREADY    (y_TREADY & y_TREADY_HEAD),

    .layer       (layer_cntr)
);

mm_ln_on_axis
#(
    .D_W               (D_W),
    .D_W_ACC           (D_W_ACC),
    .LN_BITS           (LN_BITS),
    .M1                (M1_SELF),
    .M2                (M2_SELF),
    .M3                (M3_SELF),
    .BLOCKS            (BLOCKS_SELF),
    .BLOCKS_A          (HEADS),
    .N1                (N1_SELF),
    .N2                (N2_SELF),
    .MATRIXSIZE_W      (MATRIXSIZE_W)
)
self_out_inst (
    .clk         (clk),
    .fclk        (clk),
    .rst_n       (rst_n),

    .in_x_TDATA  (y_TDATA_HEAD),
    .in_x_TVALID (y_TVALID_HEAD & y_TREADY),
    .in_x_TLAST  ((head_out_cntr == HEADS-1) & y_TLAST_HEAD & y_TREADY),
    .in_x_TREADY (y_TREADY_HEAD),
    
    .x_TDATA     (x_TDATA),
    .x_TVALID    (x_TVALID_SELF),
    .x_TLAST     (x_TLAST_SELF),
    .x_TREADY    (x_TREADY_SELF),
    .x_RCVD      (x_RCVD_SELF),

    .in_R_TDATA  (x_TDATA_I),
    .in_R_TVALID (x_TVALID_I & x_TREADY_I_HEAD & y_TREADY),
    .in_R_TLAST  (x_TLAST_I & x_TREADY_I_HEAD & y_TREADY),
    .in_R_TREADY (x_TREADY_I_SELF),

    .y_TDATA     (y_TDATA_SELF),
    .y_TVALID    (y_TVALID_SELF),
    .y_TLAST     (y_TLAST_SELF),
    .y_TREADY    (y_TREADY_SELF_INTER & y_TREADY_SELF_LAYER)
);

mm_gelu_on_axis
#(
    .D_W           (D_W),
    .D_W_ACC       (D_W_ACC),
    .LAYERS        (LAYERS),
    .M1            (M1_INTER),
    .M2            (M2_INTER),
    .M3            (M3_INTER),
    .BLOCKS        (BLOCKS_INTER),
    .BLOCKED_D     (BLOCKED_D),
    .N1            (N1_INTER),
    .N2            (N2_INTER),
    .MATRIXSIZE_W  (MATRIXSIZE_W)
)
inter_inst (
    .clk         (clk),
    .fclk        (clk),
    .rst_n       (rst_n),

    .in_x_TDATA  (y_TDATA_SELF),
    .in_x_TVALID (y_TVALID_SELF & y_TREADY_SELF_LAYER),
    .in_x_TLAST  (y_TLAST_SELF & y_TREADY_SELF_LAYER),
    .in_x_TREADY (y_TREADY_SELF_INTER),
    
    .x_TDATA     (x_TDATA),
    .x_TVALID    (x_TVALID_INTER),
    .x_TLAST     (x_TLAST_INTER),
    .x_TREADY    (x_TREADY_INTER),
    .x_RCVD      (x_RCVD_INTER),

    .y_TDATA     (y_TDATA_INTER),
    .y_TVALID    (y_TVALID_INTER),
    .y_TLAST     (y_TLAST_INTER),
    .y_TREADY    (y_TREADY_INTER),

    .layer       (layer_cntr)
);

mm_ln_on_axis
#(
    .D_W          (D_W),
    .D_W_ACC      (D_W_ACC),
    .LN_BITS      (LN_BITS),
    .M1           (M1_LAYER),
    .M2           (M2_LAYER),
    .M3           (M3_LAYER),
    .BLOCKS       (BLOCKS_LAYER),
    .BLOCKS_A     (BLOCKED_D ? BLOCKS_INTER : 1),
    .N1           (N1_LAYER),
    .N2           (N2_LAYER),
    .MATRIXSIZE_W (MATRIXSIZE_W)
)
layer_out_inst (
    .clk         (clk),
    .fclk        (clk),
    .rst_n       (rst_n),

    .in_x_TDATA  (y_TDATA_INTER),
    .in_x_TVALID (y_TVALID_INTER),
    .in_x_TLAST  (y_TLAST_INTER),
    .in_x_TREADY (y_TREADY_INTER),
    
    .x_TDATA     (x_TDATA),
    .x_TVALID    (x_TVALID_LAYER),
    .x_TLAST     (x_TLAST_LAYER),
    .x_TREADY    (x_TREADY_LAYER),
    .x_RCVD      (x_RCVD_LAYER),

    .in_R_TDATA  (y_TDATA_SELF),
    .in_R_TVALID (y_TVALID_SELF & y_TREADY_SELF_INTER),
    .in_R_TLAST  (y_TLAST_SELF & y_TREADY_SELF_INTER),
    .in_R_TREADY (y_TREADY_SELF_LAYER),

    .y_TDATA     (y_TDATA_LAYER),
    .y_TVALID    (y_TVALID_LAYER),
    .y_TLAST     (y_TLAST_LAYER),
    .y_TREADY    (y_TREADY & x_TREADY_I_HEAD & x_TREADY_I_SELF)
);

endmodule

