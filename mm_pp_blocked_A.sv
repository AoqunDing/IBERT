`timescale 1ps / 1ps

module mm_pp_blocked_A
#(
    parameter integer D_W          = 8,
    parameter integer D_W_ACC      = 32,
    parameter integer N1           = 4,
    parameter integer N2           = 4,
    parameter integer MATRIXSIZE_W = 24,
    parameter integer KEEP_A       = 1,
    parameter integer MEM_DEPTH_A  = 6144,
    parameter integer MEM_DEPTH_B  = 12288,
    parameter integer MEM_DEPTH_D  = 512,
    parameter         BLOCKED_D    = 0,
    parameter integer TRANSPOSE_B  = 0
)
(
    input  wire                    mm_clk,
    input  wire                    mm_fclk,
    input  wire                    mm_rst_n,

    axi_stream_if.axi_in           in_A,
    axi_stream_if.axi_in           in_B,
    axi_stream_if.axi_out          out_D,

    input  wire [MATRIXSIZE_W-1:0] BLOCKS,
    input  wire [MATRIXSIZE_W-1:0] BLOCK_WIDTH,
    input  wire [MATRIXSIZE_W-1:0] BLOCK_WIDTHdN2,
    input  wire [MATRIXSIZE_W-1:0] BLOCK_SIZEdN2,
    input  wire [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1xN2,
    input  wire [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1,

    input  wire [MATRIXSIZE_W-1:0] BLOCKS_A,
    input  wire [MATRIXSIZE_W-1:0] BLOCK_WIDTH_A,

    input  wire [MATRIXSIZE_W-1:0] M2,
    input  wire [MATRIXSIZE_W-1:0] M1xM3dN1,
    input  wire [MATRIXSIZE_W-1:0] M1dN1,
    input  wire [MATRIXSIZE_W-1:0] M3dN2
);

localparam integer ADDR_W_A = $clog2(MEM_DEPTH_A);
localparam integer ADDR_W_B = $clog2(MEM_DEPTH_B);
localparam integer ADDR_W_D = $clog2(MEM_DEPTH_D);

wire clk;
wire fclk;
wire rst;

assign clk  = mm_clk;
assign fclk = mm_fclk;
assign rst  = ~mm_rst_n;

wire        [N2-1:0]      init   [N1-1:0];
wire signed [D_W-1:0]     A_bram [N1-1:0];
wire signed [D_W-1:0]     B_bram [N2-1:0];
wire signed [D_W_ACC-1:0] data_D [N1-1:0];
wire        [N1-1:0]      valid_D;

wire       [ADDR_W_A-1:0] rd_addr_A;
wire       [ADDR_W_B-1:0] rd_addr_B;

wire                      done_multiply;
wire                      start_multiply;
wire                      start_multiply_block;
wire                      done_read_control;

s2mm_pp_blocked_A #(
    .D_W          (D_W),
    .N1           (N1),
    .N2           (N2),
    .MATRIXSIZE_W (MATRIXSIZE_W),
    .KEEP_A       (KEEP_A),
    .MEM_DEPTH_A  (MEM_DEPTH_A),
    .MEM_DEPTH_B  (MEM_DEPTH_B),
    .ADDR_W_A     (ADDR_W_A),
    .ADDR_W_B     (ADDR_W_B),
    .BLOCKED_D    (BLOCKED_D),
    .TRANSPOSE_B  (TRANSPOSE_B)
)
s2mm_inst (
    .clk                  (clk),
    .fclk                 (fclk),
    .rst                  (rst),
    .s_axis_s2mm_tdata_A  (in_A.tdata),
    .s_axis_s2mm_tlast_A  (in_A.tlast),
    .s_axis_s2mm_tready_A (in_A.tready),
    .s_axis_s2mm_tvalid_A (in_A.tvalid),
    .s_axis_s2mm_tdata_B  (in_B.tdata),
    .s_axis_s2mm_tlast_B  (in_B.tlast),
    .s_axis_s2mm_tready_B (in_B.tready),
    .s_axis_s2mm_tvalid_B (in_B.tvalid),
    .rd_addr_A            (rd_addr_A),
    .rd_addr_B            (rd_addr_B),
    .A_bram               (A_bram),
    .B_bram               (B_bram),

    .BLOCKS               (BLOCKS),
    .BLOCK_WIDTHdN2       (BLOCK_WIDTHdN2),
    .BLOCK_SIZEdN2        (BLOCK_SIZEdN2 ),
    .M2                   (M2),
    .M1dN1                (M1dN1),
    .M3dN2                (M3dN2),

    .BLOCKS_A             (BLOCKS_A),
    .BLOCK_WIDTH_A        (BLOCK_WIDTH_A),

    .done_multiply        (done_multiply),
    .start_multiply       (start_multiply),
    .done_read_control    (done_read_control),
    .start_multiply_block (start_multiply_block)
);

generate
    if (BLOCKED_D) begin: blocked_D
        // stores only a single block of D and streams it out
        mm2s #(
            .D_W_ACC      (D_W_ACC),
            .N1           (N1),
            .N2           (N2),
            .ADDR_W_D     (ADDR_W_D),
            .MATRIXSIZE_W (MATRIXSIZE_W),
            .MEM_DEPTH_D  (MEM_DEPTH_D)
        )
        mm2s_inst (
            .clk                (clk),
            .fclk               (fclk),
            .rst                (rst),
            .m_axis_mm2s_tdata  (out_D.tdata),
            .m_axis_mm2s_tlast  (out_D.tlast),
            .m_axis_mm2s_tready (out_D.tready),
            .m_axis_mm2s_tvalid (out_D.tvalid),
            .data_D             (data_D),
            .valid_D            (valid_D),
            .M3                 (BLOCK_WIDTH),
            .M1dN1              (M1dN1),
            .M1xM3dN1           (M1xBLOCK_WIDTHdN1),
            .done_multiply      (done_multiply)
        );
    end else begin: simple_D
        // stores all blocks of D and streams them out
        mm2s_pp #(
            .D_W_ACC      (D_W_ACC),
            .N1           (N1),
            .N2           (N2),
            .ADDR_W_D     (ADDR_W_D),
            .MATRIXSIZE_W (MATRIXSIZE_W),
            .MEM_DEPTH_D  (MEM_DEPTH_D)
        )
        mm2s_inst (
            .clk                (clk),
            .fclk               (fclk),
            .rst                (rst),
            .m_axis_mm2s_tdata  (out_D.tdata),
            .m_axis_mm2s_tlast  (out_D.tlast),
            .m_axis_mm2s_tready (out_D.tready),
            .m_axis_mm2s_tvalid (out_D.tvalid),
            .data_D             (data_D),
            .valid_D            (valid_D),
            .M1dN1              (M1dN1),
            .BLOCKS             (BLOCKS),
            .BLOCK_WIDTH        (BLOCK_WIDTH),
            .M1xBLOCK_WIDTHdN1  (M1xBLOCK_WIDTHdN1),
            .M1xM3dN1           (M1xM3dN1),
            .done_multiply      (done_multiply)
        );
    end
endgenerate

control_pp #(
    .N1           (N1),
    .N2           (N2),
    .MATRIXSIZE_W (MATRIXSIZE_W),
    .ADDR_W_A     (ADDR_W_A),
    .ADDR_W_B     (ADDR_W_B)
)
control_inst (
    .clk                  (fclk),
    .rst                  (~start_multiply | start_multiply_block),
    .M2                   (M2),
    .M1dN1                (M1dN1),
    .BLOCK_WIDTHdN2       (BLOCK_WIDTHdN2),
    .M1xBLOCK_WIDTHdN1xN2 (M1xBLOCK_WIDTHdN1xN2),
    .rd_addr_A            (rd_addr_A),
    .rd_addr_B            (rd_addr_B),
    .done_read_control    (done_read_control),
    .init                 (init)
);

systolic systolic_inst (
    .clk      (fclk),
    .rst      (~start_multiply | start_multiply_block),
    .\init[3] (init[3]),
    .\init[2] (init[2]),
    .\init[1] (init[1]),
    .\init[0] (init[0]),
    .\A[3]    (A_bram[3]),
    .\A[2]    (A_bram[2]),
    .\A[1]    (A_bram[1]),
    .\A[0]    (A_bram[0]),
    .\B[3]    (B_bram[3]),
    .\B[2]    (B_bram[2]),
    .\B[1]    (B_bram[1]),
    .\B[0]    (B_bram[0]),
    .\D[3]    (data_D[3]),
    .\D[2]    (data_D[2]),
    .\D[1]    (data_D[1]),
    .\D[0]    (data_D[0]),
    .valid_D  (valid_D)
);

endmodule
