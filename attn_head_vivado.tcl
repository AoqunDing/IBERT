source args.tcl
create_project -force head ./vivado -part xc7z020clg400-1
set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]

add_files dims.sv axi_stream_if.sv attn_head.sv attn_head_fsm.sv systolic.sv pe.sv control.sv counter.sv s2mm.sv mm2s.sv mem_read.sv mem_read_D.sv mem_write_A.sv mem_write_B.sv mem_write_D.sv mem.sv requant.sv fifo.sv softmax_top.sv rom.sv exp.sv max.sv acc.sv lopd.sv div.sv sreg.sv mm.sv softmax.sv \
    mm_pp.sv stream_vector_mem.sv stream_vector_mem_blocked.sv stream_matrix_mem.sv stream_scalar_mem.sv control_pp.sv s2mm_pp.sv mm2s_pp.sv \
    mem_read_D_pp.sv mem_write_B_pp.sv ping_pong_control.sv mem_write_A_blocked.sv mm_pp_blocked_A.sv s2mm_pp_blocked_A.sv mem_dist.sv mem_top.sv mem_par.sv


add_files clock.xdc

update_compile_order -fileset sources_1
set_property top attn_head [current_fileset]

set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]
set_property generic "D_W=8 D_W_ACC=32 SOFTMAX_N=${M1} MATRIXSIZE_W=${MATRIXSIZE_W} MEM_DEPTH_A=${MEM_DEPTH_A} MEM_DEPTH_B=${MEM_DEPTH_B} MEM_DEPTH_D=${MEM_DEPTH_D} MEM_DEPTH_Q=${MEM_DEPTH_Q} MEM_DEPTH_K=${MEM_DEPTH_K} MEM_DEPTH_S=${MEM_DEPTH_S} N1=${N1} N2=${N2} sN1=${sN1} sN2=${sN2}" [current_fileset]

if {$MODE == "synth"} {
    puts "Starting Vivado synthesis of Attention Head module..."
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1

    open_run synth_1 -name synth_1
    write_verilog -force -mode funcsim attn_head_synth.sv
    report_utilization -file attn_head_synth_util.txt
    report_timing -file attn_head_synth_timing.txt
} elseif {$MODE == "impl"} {
    puts "Starting Vivado implementation of Attention Head module..."
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1

    open_run synth_1 -name synth_1
    write_verilog -force -mode funcsim attn_head_synth.sv

    launch_runs impl_1 -jobs 4
    wait_on_run impl_1

    open_run impl_1 -name impl_1
    write_verilog -force -mode funcsim attn_head_impl.sv
    report_utilization -file attn_head_impl_util.txt
    report_timing -file attn_head_impl_timing.txt
}

exit
