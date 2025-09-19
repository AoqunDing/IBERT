`timescale 1ps / 1ps
import dims::*;

module mm_gelu_wrap
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer LAYERS        = 12,
    parameter integer N1            = 4,
    parameter integer N2            = 4,
    parameter integer MATRIXSIZE_W  = 16,
    parameter         BLOCKED_D     = 0,
    parameter integer MEM_DEPTH_A   = 4096,
    parameter integer MEM_DEPTH_B   = 4096,
    parameter integer MEM_DEPTH_D   = 4096,
    parameter integer REQ_MEM_DEPTH = 768
)
(
    input wire                      clk,
    input wire                      fclk,
    input wire                      rst,
    input wire [$clog2(LAYERS)-1:0] layer,

    input  wire signed [31:0]       s_axis_s2mm_tdata_A,
    input  wire                     s_axis_s2mm_tlast_A,
    output wire                     s_axis_s2mm_tready_A,
    input  wire                     s_axis_s2mm_tvalid_A,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W,
    input  wire                     s_axis_s2mm_tlast_W,
    output wire                     s_axis_s2mm_tready_W,
    input  wire                     s_axis_s2mm_tvalid_W,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_bias,
    input  wire                     s_axis_s2mm_tlast_W_bias,
    output wire                     s_axis_s2mm_tready_W_bias,
    input  wire                     s_axis_s2mm_tvalid_W_bias,

    input  wire signed [31:0]       s_axis_s2mm_tdata_out_m,
    input  wire                     s_axis_s2mm_tlast_out_m,
    output wire                     s_axis_s2mm_tready_out_m,
    input  wire                     s_axis_s2mm_tvalid_out_m,

    input  wire signed [31:0]       s_axis_s2mm_tdata_out_e,
    input  wire                     s_axis_s2mm_tlast_out_e,
    output wire                     s_axis_s2mm_tready_out_e,
    input  wire                     s_axis_s2mm_tvalid_out_e,

    output wire signed [D_W-1:0]    out_tdata,
    output wire                     out_tlast,
    input  wire                     out_tready,
    output wire                     out_tvalid,

    input  wire [MATRIXSIZE_W-1:0]  M1,
    input  wire [MATRIXSIZE_W-1:0]  M2,
    input  wire [MATRIXSIZE_W-1:0]  M3,
    input  wire [MATRIXSIZE_W-1:0]  M1xM3dN1,
    input  wire [MATRIXSIZE_W-1:0]  M1dN1,
    input  wire [MATRIXSIZE_W-1:0]  M3dN2,
    input  wire [MATRIXSIZE_W-1:0]  M1xM3dN1xN2,

    input  wire [MATRIXSIZE_W-1:0]  BLOCKS,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_WIDTH,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_WIDTHdN2,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_SIZEdN2,
    input  wire [MATRIXSIZE_W-1:0]  M1xBLOCK_WIDTHdN1xN2,
    input  wire [MATRIXSIZE_W-1:0]  M1xBLOCK_WIDTHdN1
);

/* verilator lint_off UNDRIVEN */
dimensions mm_dimensions;

assign mm_dimensions.M1 = M1;
assign mm_dimensions.M2 = M2;
assign mm_dimensions.M3 = M3;
assign mm_dimensions.M1xM3dN1 = M1xM3dN1;
assign mm_dimensions.M1dN1 = M1dN1;
assign mm_dimensions.M3dN2 = M3dN2;
assign mm_dimensions.M1xM3dN1xN2 = M1xM3dN1xN2;

assign mm_dimensions.BLOCKS = BLOCKS;
assign mm_dimensions.BLOCK_WIDTH = BLOCK_WIDTH;
assign mm_dimensions.BLOCK_WIDTHdN2 = BLOCK_WIDTHdN2;
assign mm_dimensions.BLOCK_SIZEdN2 = BLOCK_SIZEdN2;
assign mm_dimensions.M1xBLOCK_WIDTHdN1xN2 = M1xBLOCK_WIDTHdN1xN2;
assign mm_dimensions.M1xBLOCK_WIDTHdN1 = M1xBLOCK_WIDTHdN1;
/* verilator lint_on UNDRIVEN */

axi_stream_if A_if();
assign A_if.tdata = s_axis_s2mm_tdata_A;
assign A_if.tlast = s_axis_s2mm_tlast_A;
assign s_axis_s2mm_tready_A = A_if.tready;
assign A_if.tvalid = s_axis_s2mm_tvalid_A;

axi_stream_if W_if();
assign W_if.tdata = s_axis_s2mm_tdata_W;
assign W_if.tlast = s_axis_s2mm_tlast_W;
assign s_axis_s2mm_tready_W = W_if.tready;
assign W_if.tvalid = s_axis_s2mm_tvalid_W;

axi_stream_if W_bias_if();
assign W_bias_if.tdata = s_axis_s2mm_tdata_W_bias;
assign W_bias_if.tlast = s_axis_s2mm_tlast_W_bias;
assign s_axis_s2mm_tready_W_bias = W_bias_if.tready;
assign W_bias_if.tvalid = s_axis_s2mm_tvalid_W_bias;

axi_stream_if out_m_if();
assign out_m_if.tdata = s_axis_s2mm_tdata_out_m;
assign out_m_if.tlast = s_axis_s2mm_tlast_out_m;
assign s_axis_s2mm_tready_out_m = out_m_if.tready;
assign out_m_if.tvalid = s_axis_s2mm_tvalid_out_m;

axi_stream_if out_e_if();
assign out_e_if.tdata = s_axis_s2mm_tdata_out_e;
assign out_e_if.tlast = s_axis_s2mm_tlast_out_e;
assign s_axis_s2mm_tready_out_e = out_e_if.tready;
assign out_e_if.tvalid = s_axis_s2mm_tvalid_out_e;

axi_stream_if #(D_W) mm_gelu_out_if();
assign out_tdata = mm_gelu_out_if.tdata;
assign out_tlast = mm_gelu_out_if.tlast;
assign mm_gelu_out_if.tready = out_tready;
assign out_tvalid = mm_gelu_out_if.tvalid;

mm_gelu #(
    .D_W(D_W),
    .D_W_ACC(D_W_ACC),
    .LAYERS(LAYERS),
    .N1(N1),
    .N2(N2),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .MEM_DEPTH_A(MEM_DEPTH_A),
    .MEM_DEPTH_B(MEM_DEPTH_B),
    .MEM_DEPTH_D(MEM_DEPTH_D),
    .REQ_MEM_DEPTH(REQ_MEM_DEPTH),
    .BLOCKED_D(BLOCKED_D)
)
mm_gelu_inst (
    .clk(clk),
    .fclk(fclk),
    .rst(rst),
    .layer(layer),

    .in_A(A_if),

    .in_W(W_if),
    .in_W_bias(W_bias_if),

    .in_out_m(out_m_if),
    .in_out_e(out_e_if),

    .mm_gelu_out(mm_gelu_out_if),

    .mm_dimensions(mm_dimensions)
);

endmodule
