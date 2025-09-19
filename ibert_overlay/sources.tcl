set_property verilog_define $DEFINES [current_fileset]
add_files ../ibert_axi.v


add_files ../attn_head_on_axis.v
add_files ../axi_stream_if.sv
add_files ../attn_head_wrap.sv ../dims.sv ../attn_head.sv ../attn_head_fsm.sv
add_files ../requant.sv ../rom.sv ../fifo.sv ../softmax.sv ../softmax_top.sv ../exp.sv ../max.sv ../acc.sv ../lopd.sv ../div.sv ../sreg.sv
add_files ../stream_vector_mem.sv ../stream_vector_mem_blocked.sv ../stream_matrix_mem.sv ../stream_scalar_mem.sv

#add_files ../mm_gelu_axis.v
add_files ../mm_gelu_on_axis.v
add_files ../mm_gelu_wrap.sv ../mm_gelu.sv
add_files ../gelu.sv ../gelu_top.sv

#add_files ../mm_ln_axis.v
#add_files ../mm_ln_r_axis.v
add_files ../mm_ln_on_axis.v
add_files ../mm_ln_wrap.sv ../mm_ln.sv
add_files ../mac.sv ../sqrt.sv ../mat_add.sv ../layer_norm.sv ../layer_norm_top.sv

add_files ../mm_pp.sv ../systolic.sv ../pe.sv ../control_pp.sv ../counter.sv ../s2mm_pp.sv ../mm2s_pp.sv ../mem_read.sv ../mem_read_D_pp.sv ../mem_write_A.sv ../mem_write_B_pp.sv ../mem_write_D.sv ../ping_pong_control.sv ../mem.sv
add_files ../mm.sv ../control.sv ../s2mm.sv ../mm2s.sv ../mem_read_D.sv ../mem_write_B.sv
add_files ../mem_write_A_blocked.sv
add_files ../mm_pp_blocked_A.sv
add_files ../s2mm_pp_blocked_A.sv
add_files ../mem_top.sv ../mem_dist.sv ../mem_par.sv

set_property source_mgmt_mode All [current_project]
update_compile_order -fileset sources_1
