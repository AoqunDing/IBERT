`timescale 1ps / 1ps
import dims::*;

module attn_head_wrap
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer N1            = 4,
    parameter integer N2            = 4,
    parameter integer sN1           = 4,
    parameter integer sN2           = 4,
    parameter integer LAYERS        = 12,
    parameter integer SOFTMAX_N     = 32,
    parameter integer MATRIXSIZE_W  = 24,
    parameter integer KEEP_A        = 1,
    parameter integer MEM_DEPTH_A   = 4096,
    parameter integer MEM_DEPTH_B   = 4096,
    parameter integer MEM_DEPTH_D   = 4096,
    parameter integer MEM_DEPTH_Q   = 4096,
    parameter integer MEM_DEPTH_K   = 4096,
    parameter integer MEM_DEPTH_S   = 4096,
    parameter integer REQ_MEM_DEPTH = 64
)
(
    input wire                      clk,
    input wire                      fclk,
    input wire                      rst,
    input wire [$clog2(LAYERS)-1:0] layer,

    input  wire signed [31:0]       s_axis_s2mm_tdata_I,
    input  wire                     s_axis_s2mm_tlast_I,
    output wire                     s_axis_s2mm_tready_I,
    input  wire                     s_axis_s2mm_tvalid_I,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_Q,
    input  wire                     s_axis_s2mm_tlast_W_Q,
    output wire                     s_axis_s2mm_tready_W_Q,
    input  wire                     s_axis_s2mm_tvalid_W_Q,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_K,
    input  wire                     s_axis_s2mm_tlast_W_K,
    output wire                     s_axis_s2mm_tready_W_K,
    input  wire                     s_axis_s2mm_tvalid_W_K,

    input  wire signed [31:0]       s_axis_s2mm_tdata_W_V,
    input  wire                     s_axis_s2mm_tlast_W_V,
    output wire                     s_axis_s2mm_tready_W_V,
    input  wire                     s_axis_s2mm_tvalid_W_V,

    input  wire signed [31:0]       s_axis_s2mm_tdata_bias_Q,
    input  wire                     s_axis_s2mm_tlast_bias_Q,
    output wire                     s_axis_s2mm_tready_bias_Q,
    input  wire                     s_axis_s2mm_tvalid_bias_Q,

    input  wire signed [31:0]       s_axis_s2mm_tdata_bias_K,
    input  wire                     s_axis_s2mm_tlast_bias_K,
    output wire                     s_axis_s2mm_tready_bias_K,
    input  wire                     s_axis_s2mm_tvalid_bias_K,

    input  wire signed [31:0]       s_axis_s2mm_tdata_bias_V,
    input  wire                     s_axis_s2mm_tlast_bias_V,
    output wire                     s_axis_s2mm_tready_bias_V,
    input  wire                     s_axis_s2mm_tvalid_bias_V,

    input  wire signed [31:0]       s_axis_s2mm_tdata_m_Q,
    input  wire                     s_axis_s2mm_tlast_m_Q,
    output wire                     s_axis_s2mm_tready_m_Q,
    input  wire                     s_axis_s2mm_tvalid_m_Q,

    input  wire signed [31:0]       s_axis_s2mm_tdata_m_K,
    input  wire                     s_axis_s2mm_tlast_m_K,
    output wire                     s_axis_s2mm_tready_m_K,
    input  wire                     s_axis_s2mm_tvalid_m_K,
    
    input  wire signed [31:0]       s_axis_s2mm_tdata_m_V,
    input  wire                     s_axis_s2mm_tlast_m_V,
    output wire                     s_axis_s2mm_tready_m_V,
    input  wire                     s_axis_s2mm_tvalid_m_V,

    input  wire        [31:0]       s_axis_s2mm_tdata_e_Q,
    input  wire                     s_axis_s2mm_tlast_e_Q,
    output wire                     s_axis_s2mm_tready_e_Q,
    input  wire                     s_axis_s2mm_tvalid_e_Q,

    input  wire        [31:0]       s_axis_s2mm_tdata_e_K,
    input  wire                     s_axis_s2mm_tlast_e_K,
    output wire                     s_axis_s2mm_tready_e_K,
    input  wire                     s_axis_s2mm_tvalid_e_K,

    input  wire        [31:0]       s_axis_s2mm_tdata_e_V,
    input  wire                     s_axis_s2mm_tlast_e_V,
    output wire                     s_axis_s2mm_tready_e_V,
    input  wire                     s_axis_s2mm_tvalid_e_V,

    input  wire signed [31:0]       s_axis_s2mm_tdata_m_C,
    input  wire                     s_axis_s2mm_tlast_m_C,
    output wire                     s_axis_s2mm_tready_m_C,
    input  wire                     s_axis_s2mm_tvalid_m_C,

    input  wire        [31:0]       s_axis_s2mm_tdata_e_C,
    input  wire                     s_axis_s2mm_tlast_e_C,
    output wire                     s_axis_s2mm_tready_e_C,
    input  wire                     s_axis_s2mm_tvalid_e_C,

    `ifdef ONESYS
    `ifdef PING_PONG
    `ifdef READ_A
    output wire signed [D_W-1:0]    m_axis_mm2s_tdata_I,
    output wire                     m_axis_mm2s_tlast_I,
    input  wire                     m_axis_mm2s_tready_I,
    output wire                     m_axis_mm2s_tvalid_I,
    `endif
    `endif
    `endif

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
    input  wire [MATRIXSIZE_W-1:0]  M1xM1dN1,
    input  wire [MATRIXSIZE_W-1:0]  M1xM1dN1xN1,

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
assign mm_dimensions.M1xM1dN1 = M1xM1dN1;
assign mm_dimensions.M1xM1dN1xN1 = M1xM1dN1xN1;

assign mm_dimensions.BLOCKS = BLOCKS;
assign mm_dimensions.BLOCK_WIDTH = BLOCK_WIDTH;
assign mm_dimensions.BLOCK_WIDTHdN2 = BLOCK_WIDTHdN2;
assign mm_dimensions.BLOCK_SIZEdN2 = BLOCK_SIZEdN2;
assign mm_dimensions.M1xBLOCK_WIDTHdN1xN2 = M1xBLOCK_WIDTHdN1xN2;
assign mm_dimensions.M1xBLOCK_WIDTHdN1 = M1xBLOCK_WIDTHdN1;
/* verilator lint_on UNDRIVEN */

axi_stream_if I_if();
assign I_if.tdata = s_axis_s2mm_tdata_I;
assign I_if.tlast = s_axis_s2mm_tlast_I;
assign s_axis_s2mm_tready_I = I_if.tready;
assign I_if.tvalid = s_axis_s2mm_tvalid_I;

axi_stream_if W_Q_if();
assign W_Q_if.tdata = s_axis_s2mm_tdata_W_Q;
assign W_Q_if.tlast = s_axis_s2mm_tlast_W_Q;
assign s_axis_s2mm_tready_W_Q = W_Q_if.tready;
assign W_Q_if.tvalid = s_axis_s2mm_tvalid_W_Q;

axi_stream_if W_K_if();
assign W_K_if.tdata = s_axis_s2mm_tdata_W_K;
assign W_K_if.tlast = s_axis_s2mm_tlast_W_K;
assign s_axis_s2mm_tready_W_K = W_K_if.tready;
assign W_K_if.tvalid = s_axis_s2mm_tvalid_W_K;

axi_stream_if W_V_if();
assign W_V_if.tdata = s_axis_s2mm_tdata_W_V;
assign W_V_if.tlast = s_axis_s2mm_tlast_W_V;
assign s_axis_s2mm_tready_W_V = W_V_if.tready;
assign W_V_if.tvalid = s_axis_s2mm_tvalid_W_V;

axi_stream_if bias_Q_if();
assign bias_Q_if.tdata = s_axis_s2mm_tdata_bias_Q;
assign bias_Q_if.tlast = s_axis_s2mm_tlast_bias_Q;
assign s_axis_s2mm_tready_bias_Q = bias_Q_if.tready;
assign bias_Q_if.tvalid = s_axis_s2mm_tvalid_bias_Q;

axi_stream_if bias_K_if();
assign bias_K_if.tdata = s_axis_s2mm_tdata_bias_K;
assign bias_K_if.tlast = s_axis_s2mm_tlast_bias_K;
assign s_axis_s2mm_tready_bias_K = bias_K_if.tready;
assign bias_K_if.tvalid = s_axis_s2mm_tvalid_bias_K;

axi_stream_if bias_V_if();
assign bias_V_if.tdata = s_axis_s2mm_tdata_bias_V;
assign bias_V_if.tlast = s_axis_s2mm_tlast_bias_V;
assign s_axis_s2mm_tready_bias_V = bias_V_if.tready;
assign bias_V_if.tvalid = s_axis_s2mm_tvalid_bias_V;

axi_stream_if m_Q_if();
assign m_Q_if.tdata = s_axis_s2mm_tdata_m_Q;
assign m_Q_if.tlast = s_axis_s2mm_tlast_m_Q;
assign s_axis_s2mm_tready_m_Q = m_Q_if.tready;
assign m_Q_if.tvalid = s_axis_s2mm_tvalid_m_Q;

axi_stream_if m_K_if();
assign m_K_if.tdata = s_axis_s2mm_tdata_m_K;
assign m_K_if.tlast = s_axis_s2mm_tlast_m_K;
assign s_axis_s2mm_tready_m_K = m_K_if.tready;
assign m_K_if.tvalid = s_axis_s2mm_tvalid_m_K;

axi_stream_if m_V_if();
assign m_V_if.tdata = s_axis_s2mm_tdata_m_V;
assign m_V_if.tlast = s_axis_s2mm_tlast_m_V;
assign s_axis_s2mm_tready_m_V = m_V_if.tready;
assign m_V_if.tvalid = s_axis_s2mm_tvalid_m_V;

axi_stream_if e_Q_if();
assign e_Q_if.tdata = s_axis_s2mm_tdata_e_Q;
assign e_Q_if.tlast = s_axis_s2mm_tlast_e_Q;
assign s_axis_s2mm_tready_e_Q = e_Q_if.tready;
assign e_Q_if.tvalid = s_axis_s2mm_tvalid_e_Q;

axi_stream_if e_K_if();
assign e_K_if.tdata = s_axis_s2mm_tdata_e_K;
assign e_K_if.tlast = s_axis_s2mm_tlast_e_K;
assign s_axis_s2mm_tready_e_K = e_K_if.tready;
assign e_K_if.tvalid = s_axis_s2mm_tvalid_e_K;

axi_stream_if e_V_if();
assign e_V_if.tdata = s_axis_s2mm_tdata_e_V;
assign e_V_if.tlast = s_axis_s2mm_tlast_e_V;
assign s_axis_s2mm_tready_e_V = e_V_if.tready;
assign e_V_if.tvalid = s_axis_s2mm_tvalid_e_V;

axi_stream_if m_C_if();
assign m_C_if.tdata = s_axis_s2mm_tdata_m_C;
assign m_C_if.tlast = s_axis_s2mm_tlast_m_C;
assign s_axis_s2mm_tready_m_C = m_C_if.tready;
assign m_C_if.tvalid = s_axis_s2mm_tvalid_m_C;

axi_stream_if e_C_if();
assign e_C_if.tdata = s_axis_s2mm_tdata_e_C;
assign e_C_if.tlast = s_axis_s2mm_tlast_e_C;
assign s_axis_s2mm_tready_e_C = e_C_if.tready;
assign e_C_if.tvalid = s_axis_s2mm_tvalid_e_C;

axi_stream_if #(D_W) attn_head_out_if();
assign out_tdata = attn_head_out_if.tdata;
assign out_tlast = attn_head_out_if.tlast;
assign out_tvalid = attn_head_out_if.tvalid;
assign attn_head_out_if.tready = out_tready;

attn_head #(

    .D_W           (D_W),
    .D_W_ACC       (D_W_ACC),
    .N1            (N1),
    .N2            (N2),
    .sN1           (sN1),
    .sN2           (sN2),
    .LAYERS        (LAYERS),
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
attn_head_inst (
    .clk(clk),
    .fclk(fclk),
    .rst(rst),
    .layer(layer),

    .in_I(I_if),

    .in_W_Q(W_Q_if),
    .in_W_K(W_K_if),
    .in_W_V(W_V_if),

    .in_bias_Q(bias_Q_if),
    .in_bias_K(bias_K_if),
    .in_bias_V(bias_V_if),

    .in_m_Q(m_Q_if),
    .in_m_K(m_K_if),
    .in_m_V(m_V_if),

    .in_e_Q(e_Q_if),
    .in_e_K(e_K_if),
    .in_e_V(e_V_if),

    .in_m_C(m_C_if),
    .in_e_C(e_C_if),

    .attn_head_out(attn_head_out_if),

    .mm_dimensions(mm_dimensions)
);

endmodule
