set ila_inst0 ila0
# set ila_inst1 ila1
create_debug_core  $ila_inst0        ila
# create_debug_core  $ila_inst1        ila
set_property       C_DATA_DEPTH     4096 [get_debug_cores $ila_inst0]
# set_property       C_DATA_DEPTH     2048 [get_debug_cores $ila_inst1]
set_property       C_ADV_TRIGGER    true [get_debug_cores $ila_inst0]
# set_property       C_ADV_TRIGGER    true [get_debug_cores $ila_inst1]

# adding clock and reset
set_property       port_width 1     [get_debug_ports $ila_inst0/clk]
connect_debug_port $ila_inst0/clk   [get_nets tutorial_i/mm_eval/ibert_0/clk]
# set_property       port_width 1     [get_debug_ports $ila_inst1/clk]
# connect_debug_port $ila_inst1/clk    [get_nets tutorial_i/poly_eval/poly_0/clk]

set_property       port_width 213     [get_debug_ports $ila_inst0/probe0]
connect_debug_port $ila_inst0/probe0  [get_nets [list \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/rst} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/layer*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_I} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_I} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_I} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_W_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_W_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_W_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_W_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_W_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_W_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_W_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_W_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_W_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_bias_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_bias_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_bias_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_bias_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_bias_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_bias_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_bias_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_bias_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_bias_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_e_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_e_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_e_Q} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_e_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_e_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_e_K} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_e_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_e_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_e_V} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tdata_W*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tlast_W} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tready_W} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/s_axis_s2mm_tvalid_W} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/m_axis_mm2s_tdata_QKV*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/m_axis_mm2s_tlast_QKV} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/m_axis_mm2s_tready_QKV} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/m_axis_mm2s_tvalid_QKV} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/requant_tdata_QKV*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/requant_tlast_QKV} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/requant_tready_QKV} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/requant_tvalid_QKV} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/softmax_qout*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/softmax_out_v} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/softmax_last} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/tx_curr_state*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/out_curr_state*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/systolic_inst/A[0]*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/systolic_inst/B[0]*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/s2mm_inst/activate_A*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/s2mm_inst/activate_B*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/systolic_inst/valid_D*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/systolic_inst/D[0]*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/done_multiply} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/start_multiply} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/s2mm_inst/write_done_sync*} \
            {tutorial_i/mm_eval/ibert_0/inst/attn_head_axis_inst/attn_head_wrap_inst/attn_head_inst/mm_QKV/s2mm_inst/keep_A_cntr[*]} \
            ]]

# set_property       port_width 37     [get_debug_ports $ila_inst1/probe0]
# connect_debug_port $ila_inst1/probe0  [get_nets [list {tutorial_i/poly_eval/poly_0/rst_n} \
# 					{tutorial_i/poly_eval/poly_0/y_TVALID} \
# 					{tutorial_i/poly_eval/poly_0/y_TREADY} \
# 					{tutorial_i/poly_eval/poly_0/y_TLAST[0]} \
# 					{tutorial_i/poly_eval/poly_0/y_TDATA*} \
# 					{tutorial_i/poly_eval/poly_0/y_TREADY}]]
