source args.tcl
create_project -force mm_ln ./vivado -part xc7z020clg400-1
set_property board_part www.digilentinc.com:pynq-z1:part0:1.0 [current_project]

add_files dims.sv axi_stream_if.sv systolic.sv pe.sv control_pp.sv counter.sv s2mm_pp_blocked_A.sv mm2s_pp.sv mem_read.sv mem_read_D_pp.sv mem_write_A_blocked.sv mem_write_B_pp.sv mem_write_D.sv mem.sv mem_top.sv mem_par.sv mem_dist.sv requant.sv fifo.sv acc.sv mac.sv sqrt.sv lopd.sv sreg.sv div.sv mat_add.sv layer_norm.sv layer_norm_top.sv mm_pp_blocked_A.sv mm_ln.sv ping_pong_control.sv stream_vector_mem.sv stream_matrix_mem.sv stream_scalar_mem.sv
add_files clock.xdc

update_compile_order -fileset sources_1
set_property top mm_ln [current_fileset]

set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]
set_property generic "D_W=8 D_W_ACC=32 LN_BITS=22 MATRIXSIZE_W=${MATRIXSIZE_W} MEM_DEPTH_A=${MEM_DEPTH_A} MEM_DEPTH_B=${MEM_DEPTH_B} MEM_DEPTH_D=${MEM_DEPTH_D} MAT_ADD_MEM_DEPTH=${MAT_ADD_MEM_DEPTH} N1=${N1} N2=${N2}" [current_fileset]

if {$MODE == "synth"} {
    puts "Starting Vivado synthesis of mm_ln module..."
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1

    open_run synth_1 -name synth_1
    write_verilog -force -mode funcsim mm_ln_synth.sv
    report_utilization -file mm_ln_synth_util.txt
    report_timing -file mm_ln_synth_timing.txt
} elseif {$MODE == "impl"} {
    puts "Starting Vivado implementation of mm_ln module..."
    launch_runs synth_1 -jobs 4
    wait_on_run synth_1

    open_run synth_1 -name synth_1
    write_verilog -force -mode funcsim mm_ln_synth.sv

    launch_runs impl_1 -jobs 4
    wait_on_run impl_1

    open_run impl_1 -name impl_1
    write_verilog -force -mode funcsim mm_ln_impl.sv
    report_utilization -file mm_ln_impl_util.txt
    report_timing -file mm_ln_impl_timing.txt
}

exit
