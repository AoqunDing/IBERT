`timescale 1ps / 1ps

module layer_norm_top
#(
    parameter integer D_W = 8,
    parameter integer D_W_ACC = 32,
    parameter integer MATRIXSIZE_W = 24
)
(
    input  wire                       clk,
    input  wire                       rst,

    axi_stream_if.axi_in              in_ln_bias,
    axi_stream_if.axi_in              qin,
    axi_stream_if.axi_out             qout,

    input  wire [MATRIXSIZE_W-1:0]    DIM1,
    input  wire [MATRIXSIZE_W-1:0]    DIM2
);

axi_stream_if #(D_W_ACC) ln_bias ();

localparam integer               N        = 768;
localparam [D_W_ACC-1:0]         N_INV    = 1398101;
localparam integer               FP_BITS  = 30;
localparam integer               MAX_BITS = 31;
localparam [$clog2(D_W_ACC)-1:0] SHIFT    = 6;
localparam integer               ADDR_W   = $clog2(N);

wire [MATRIXSIZE_W-1:0] qout_col_cntr;
wire [MATRIXSIZE_W-1:0] qout_row_cntr;

reg signed [D_W_ACC-1:0] qin_tdata_reg;
reg signed [D_W_ACC-1:0] ln_bias_tdata_reg;

reg qin_tvalid_reg = 0;
reg ln_bias_tvalid_reg = 0;

wire in_tvalid_s0;
wire in_tready_s0;
wire in_tready_s1;

assign qout.tlast = (qout_row_cntr == DIM1-1) && (qout_col_cntr == DIM2-1);

// register everyone at least once when in_tready_s0 is low
assign qin.tready = in_tready_s0 | ~qin_tvalid_reg;
assign ln_bias.tready = in_tready_s0 | ~ln_bias_tvalid_reg;

// now I need everyone to be valid after first pass
assign in_tvalid_s0 = qin_tvalid_reg & ln_bias_tvalid_reg;
assign in_tready_s0 = in_tready_s1 & in_tvalid_s0;

// s1 stage
assign in_tready_s1 = qout.tready | ~qout.tvalid;

always @(posedge clk) begin
    if (rst) begin
        qin_tvalid_reg <= 0;
        ln_bias_tvalid_reg <= 0;
        qin_tdata_reg <= 0;
        ln_bias_tdata_reg <= 0;
    end else begin
        if (qin.tready) begin
            qin_tdata_reg <= qin.tdata;
            qin_tvalid_reg <= qin.tvalid;
        end

        if (ln_bias.tready) begin
            ln_bias_tdata_reg <= ln_bias.tdata;
            ln_bias_tvalid_reg <= ln_bias.tvalid;
        end
    end
end

counter #(
    .MATRIXSIZE_W (MATRIXSIZE_W)
)
counter_ln (
    .clk                (clk),
    .rst                (rst),
    .enable_pixel_count (qout.tvalid & qout.tready),
    .enable_slice_count (1'b1),
    .WIDTH              (DIM2),
    .HEIGHT             (DIM1),
    .pixel_cntr         (qout_col_cntr),
    .slice_cntr         (qout_row_cntr)
);

stream_vector_mem #(
    .D_W(D_W_ACC),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .MEM_DEPTH(N)
)
vec_mem_ln_bias (
    .clk(clk),
    .rst(rst),

    .in_vec(in_ln_bias),
    .out_vec(ln_bias),

    .DIM1(DIM1),
    .DIM2(DIM2)
);

layer_norm layer_norm_unit (
    .clk       ( clk           ),
    .rst       ( rst           ),
    .enable    ( in_tready_s1  ),
    .in_valid  ( in_tvalid_s0  ),
    .qin       ( qin_tdata_reg ),
    .bias      ( ln_bias_tdata_reg ),
    .shift     ( SHIFT         ),
    .out_valid ( qout.tvalid   ),
    .qout      ( qout.tdata    )
);

endmodule
