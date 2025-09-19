`timescale 1ps / 1ps
import dims::*;

module mm_ln_wrap
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer LN_BITS       = 22,
    parameter integer N1            = 4,
    parameter integer N2            = 4,
    parameter integer MATRIXSIZE_W  = 16,
    parameter         BLOCKED_A     = 0,
    parameter integer MEM_DEPTH_A   = 4096,
    parameter integer MEM_DEPTH_B   = 4096,
    parameter integer MEM_DEPTH_D   = 4096,
    parameter integer MAT_ADD_MEM_DEPTH = 4096,
    parameter integer REQ_MEM_DEPTH = 768
)
(
    input wire                      clk,
    input wire                      fclk,
    input wire                      rst,

    input  wire signed [31:0]       s_axis_s2mm_tdata_X,
    input  wire                     s_axis_s2mm_tlast_X,
    output wire                     s_axis_s2mm_tready_X,
    input  wire                     s_axis_s2mm_tvalid_X,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W,
    input  wire                     s_axis_s2mm_tlast_W,
    output wire                     s_axis_s2mm_tready_W,
    input  wire                     s_axis_s2mm_tvalid_W,
    
    input  wire signed [31:0]       s_axis_s2mm_tdata_R,
    input  wire                     s_axis_s2mm_tlast_R,
    output wire                     s_axis_s2mm_tready_R,
    input  wire                     s_axis_s2mm_tvalid_R,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_bias,
    input  wire                     s_axis_s2mm_tlast_W_bias,
    output wire                     s_axis_s2mm_tready_W_bias,
    input  wire                     s_axis_s2mm_tvalid_W_bias,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_m,
    input  wire                     s_axis_s2mm_tlast_W_m,
    output wire                     s_axis_s2mm_tready_W_m,
    input  wire                     s_axis_s2mm_tvalid_W_m,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_e,
    input  wire                     s_axis_s2mm_tlast_W_e,
    output wire                     s_axis_s2mm_tready_W_e,
    input  wire                     s_axis_s2mm_tvalid_W_e,
    
    input  wire signed [31:0]       s_axis_s2mm_tdata_R_m,
    input  wire                     s_axis_s2mm_tlast_R_m,
    output wire                     s_axis_s2mm_tready_R_m,
    input  wire                     s_axis_s2mm_tvalid_R_m,

    input  wire signed [31:0]       s_axis_s2mm_tdata_R_e,
    input  wire                     s_axis_s2mm_tlast_R_e,
    output wire                     s_axis_s2mm_tready_R_e,
    input  wire                     s_axis_s2mm_tvalid_R_e,

    input  wire signed [31:0]       s_axis_s2mm_tdata_ln_bias,
    input  wire                     s_axis_s2mm_tlast_ln_bias,
    output wire                     s_axis_s2mm_tready_ln_bias,
    input  wire                     s_axis_s2mm_tvalid_ln_bias,

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
    input  wire [MATRIXSIZE_W-1:0]  M1xM3,
    input  wire [MATRIXSIZE_W-1:0]  M1xM3dN1,
    input  wire [MATRIXSIZE_W-1:0]  M1dN1,
    input  wire [MATRIXSIZE_W-1:0]  M3dN2,
    input  wire [MATRIXSIZE_W-1:0]  M1xM3dN1xN2,

    input  wire [MATRIXSIZE_W-1:0]  BLOCKS,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_WIDTH,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_WIDTHdN2,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_SIZEdN2,
    input  wire [MATRIXSIZE_W-1:0]  M1xBLOCK_WIDTHdN1xN2,
    input  wire [MATRIXSIZE_W-1:0]  M1xBLOCK_WIDTHdN1,
    input  wire [MATRIXSIZE_W-1:0]  BLOCKS_A,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_WIDTH_A
);

/* verilator lint_off UNDRIVEN */
dimensions mm_dimensions;

assign mm_dimensions.M1 = M1;
assign mm_dimensions.M2 = M2;
assign mm_dimensions.M3 = M3;
assign mm_dimensions.M1xM3 = M1xM3;
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
assign mm_dimensions.BLOCKS_A = BLOCKS_A;
assign mm_dimensions.BLOCK_WIDTH_A = BLOCK_WIDTH_A;
/* verilator lint_on UNDRIVEN */

axi_stream_if X_if();
assign X_if.tdata = s_axis_s2mm_tdata_X;
assign X_if.tlast = s_axis_s2mm_tlast_X;
assign s_axis_s2mm_tready_X = X_if.tready;
assign X_if.tvalid = s_axis_s2mm_tvalid_X;

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

axi_stream_if W_m_if();
assign W_m_if.tdata = s_axis_s2mm_tdata_W_m;
assign W_m_if.tlast = s_axis_s2mm_tlast_W_m;
assign s_axis_s2mm_tready_W_m = W_m_if.tready;
assign W_m_if.tvalid = s_axis_s2mm_tvalid_W_m;

axi_stream_if W_e_if();
assign W_e_if.tdata = s_axis_s2mm_tdata_W_e;
assign W_e_if.tlast = s_axis_s2mm_tlast_W_e;
assign s_axis_s2mm_tready_W_e = W_e_if.tready;
assign W_e_if.tvalid = s_axis_s2mm_tvalid_W_e;

axi_stream_if R_if();
assign R_if.tdata = s_axis_s2mm_tdata_R;
assign R_if.tlast = s_axis_s2mm_tlast_R;
assign s_axis_s2mm_tready_R = R_if.tready;
assign R_if.tvalid = s_axis_s2mm_tvalid_R;

axi_stream_if R_m_if();
assign R_m_if.tdata = s_axis_s2mm_tdata_R_m;
assign R_m_if.tlast = s_axis_s2mm_tlast_R_m;
assign s_axis_s2mm_tready_R_m = R_m_if.tready;
assign R_m_if.tvalid = s_axis_s2mm_tvalid_R_m;

axi_stream_if R_e_if();
assign R_e_if.tdata = s_axis_s2mm_tdata_R_e;
assign R_e_if.tlast = s_axis_s2mm_tlast_R_e;
assign s_axis_s2mm_tready_R_e = R_e_if.tready;
assign R_e_if.tvalid = s_axis_s2mm_tvalid_R_e;

axi_stream_if ln_bias_if();
assign ln_bias_if.tdata = s_axis_s2mm_tdata_ln_bias;
assign ln_bias_if.tlast = s_axis_s2mm_tlast_ln_bias;
assign s_axis_s2mm_tready_ln_bias = ln_bias_if.tready;
assign ln_bias_if.tvalid = s_axis_s2mm_tvalid_ln_bias;

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

axi_stream_if #(D_W) mm_ln_out_if();
assign out_tdata = mm_ln_out_if.tdata;
assign out_tlast = mm_ln_out_if.tlast;
assign mm_ln_out_if.tready = out_tready;
assign out_tvalid = mm_ln_out_if.tvalid;

mm_ln #(
    .D_W(D_W),
    .D_W_ACC(D_W_ACC),
    .LN_BITS(LN_BITS),
    .N1(N1),
    .N2(N2),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .BLOCKED_A(BLOCKED_A),
    .MEM_DEPTH_A(MEM_DEPTH_A),
    .MEM_DEPTH_B(MEM_DEPTH_B),
    .MEM_DEPTH_D(MEM_DEPTH_D),
    .MAT_ADD_MEM_DEPTH(MAT_ADD_MEM_DEPTH),
    .REQ_MEM_DEPTH(REQ_MEM_DEPTH)
)
mm_ln_inst (
    .clk(clk),
    .fclk(fclk),
    .rst(rst),

    .in_X(X_if),

    .in_W(W_if),
    .in_W_bias(W_bias_if),
    .in_W_m(W_m_if),
    .in_W_e(W_e_if),

    .in_R(R_if),
    .in_R_m(R_m_if),
    .in_R_e(R_e_if),

    .in_ln_bias(ln_bias_if),

    .in_out_m(out_m_if),
    .in_out_e(out_e_if),

    .mm_ln_out(mm_ln_out_if),

    .mm_dimensions(mm_dimensions)
);

endmodule
