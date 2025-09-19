set_param general.maxThreads 4

source args.tcl
source tutorial.tcl

add_files -norecurse [make_wrapper -files [get_files "[current_bd_design].bd"] -top]
read_xdc tutorial.xdc

set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.ARGS.DIRECTIVE AddRetime [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]
set_property STEPS.POST_ROUTE_PHYS_OPT_DESIGN.ARGS.DIRECTIVE AggressiveExplore [get_runs impl_1]

update_compile_order -fileset sources_1
set_property top tutorial_wrapper [current_fileset]

update_compile_order -fileset sources_1
check_ip_cache -clear_output_repo

launch_runs synth_1 -jobs 4
if {$TIMEOUT} {
	wait_on_run -timeout 25 synth_1
} else {
	wait_on_run -timeout 120 synth_1
}

file copy -force tutorial/tutorial.runs/tutorial_ibert_0_0_synth_1/runme.log synth.log

if ($DEBUG) {
    open_run synth_1
    source debug.tcl
}

launch_runs impl_1 -to_step write_bitstream -jobs 4
if {$TIMEOUT} {
	wait_on_run -timeout 50 impl_1
} else {
	wait_on_run -timeout 120 impl_1
}

open_run impl_1
report_utilization -file utilization.txt
report_utilization -hierarchical -file utilization_hier.txt
report_timing -file timing.txt

if ($DEBUG) {
    file copy -force tutorial/tutorial.runs/impl_1/tutorial_wrapper.ltx tutorial.ltx
}
file copy -force tutorial/tutorial.runs/impl_1/tutorial_wrapper.bit tutorial_${N1}_${N2}.bit
file copy -force tutorial/tutorial.gen/sources_1/bd/tutorial/hw_handoff/tutorial.hwh tutorial_${N1}_${N2}.hwh
close_project

exit
