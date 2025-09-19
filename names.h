// attn_head
`ifdef ONESYS
    `define mm_Q mm_QKV
    `define mm_K mm_QKV
    `define mm_V mm_QKV
    `define requant_Q requant_QKV
    `define requant_K requant_QKV
    `define requant_V requant_QKV
`else
    `define mm_Q mm_Q
    `define mm_K mm_K
    `define mm_V mm_V
    `define requant_Q requant_Q
    `define requant_K requant_K
    `define requant_V requant_V
`endif
`define mm_S mm_S
`define mm_C mm_C
`define softmax softmax_top_unit
`define requant_C requant_C

// mm_ln
// with BLOCKED_A=1
`define mm_Y mm_Y
`define requant_Y requant_Y
`define requant_R requant_R
`define mat_add_Z mat_add_Z
`define layer_norm_top layer_norm_top_unit

// mm_gelu
`define mm_G mm_G
`define requant_G requant_G
`define gelu_top gelu_top_unit
`define requant_out requant_out
