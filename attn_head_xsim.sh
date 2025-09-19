#!/bin/zsh

M1=$1
M2=$2
M3=$3
N1=$4
N2=$5
MATRIXSIZE_W=$6
MEM_DEPTH_A=$7
MEM_DEPTH_B=$8
MEM_DEPTH_D_A=$9
MEM_DEPTH_D_B=$10
MEM_DEPTH_S=$11
GUI=$12
MODE=$13

if [ "$MODE" = "" ]; then
    echo "Starting functional simulation of attention head module..."
    xvlog -sv attn_dims.sv attn_head_tb.sv attn_head.sv systolic.sv pe.sv control.sv counter.sv s2mm.sv mm2s.sv mem_read.sv mem_read_D.sv mem_write_A.sv mem_write_B.sv mem_write_D.sv mem.sv requant.sv fifo.sv s2v.sv rom.sv max.sv acc.sv lopd.sv sreg.sv softmax_top.sv glbl.v exp.sv div.sv softmax.sv mm.sv
    xelab --O3 --generic_top "MATRIXSIZE_W=$MATRIXSIZE_W" --generic_top "MEM_DEPTH_A=$MEM_DEPTH_A" --generic_top "MEM_DEPTH_B=$MEM_DEPTH_B" --generic_top "MEM_DEPTH_D_A=$MEM_DEPTH_D_A" --generic_top "MEM_DEPTH_D_B=$MEM_DEPTH_D_B" --generic_top "MEM_DEPTH_S=$MEM_DEPTH_S" --generic_top "M1=$M1" --generic_top "M2=$M2" --generic_top "M3=$M3" --generic_top "N1=$N1" --generic_top "N2=$N2" -debug typical -L secureip -L simprims_ver glbl attn_head_tb -s attn_head_tb
else
   if [ "$MODE" = "synth" ]; then
       if [ -e "attn_head_synth.sv" ]; then
           echo "Starting post-synthesis simulation of attention head module..."
           xvlog -d XIL_TIMING -sv attn_dims.sv attn_head_tb.sv attn_head_synth.sv
           xelab --O3 --generic_top "MATRIXSIZE_W=$MATRIXSIZE_W" --generic_top "MEM_DEPTH_A=$MEM_DEPTH_A" --generic_top "MEM_DEPTH_B=$MEM_DEPTH_B" --generic_top "MEM_DEPTH_D_A=$MEM_DEPTH_D_A" --generic_top "MEM_DEPTH_D_B=$MEM_DEPTH_D_B" --generic_top "MEM_DEPTH_S=$MEM_DEPTH_S" --generic_top "M1=$M1" --generic_top "M2=$M2" --generic_top "M3=$M3" --generic_top "N1=$N1" --generic_top "N2=$N2" -debug typical -maxdelay -L secureip -L simprims_ver -transport_int_delays -pulse_r 0 -pulse_int_r 0 glbl attn_head_tb -s attn_head_tb
       else
           echo "Error: Can not find file attn_head_synth.sv. Make sure to complete synthesis step first: make head-synth"
           exit 1
       fi
   elif [ "$MODE" = "impl" ]; then
       if [ -e "attn_head_impl.sv" ]; then
           echo "Starting post-implementation simulation of attention head module..."
           xvlog -d XIL_TIMING -sv attn_dims.sv attn_head_tb.sv attn_head_impl.sv
           xelab --O3 --generic_top "MATRIXSIZE_W=$MATRIXSIZE_W" --generic_top "MEM_DEPTH_A=$MEM_DEPTH_A" --generic_top "MEM_DEPTH_B=$MEM_DEPTH_B" --generic_top "MEM_DEPTH_D_A=$MEM_DEPTH_D_A" --generic_top "MEM_DEPTH_D_B=$MEM_DEPTH_D_B" --generic_top "MEM_DEPTH_S=$MEM_DEPTH_S" --generic_top "M1=$M1" --generic_top "M2=$M2" --generic_top "M3=$M3" --generic_top "N1=$N1" --generic_top "N2=$N2" -debug typical -maxdelay -L secureip -L simprims_ver -transport_int_delays -pulse_r 0 -pulse_int_r 0 -pulse_e 0 -pulse_int_e 0 glbl attn_head_tb -s attn_head_tb
       else
           echo "Error: Can not find file attn_head_impl.sv. Make sure to complete implementation step first: make head-impl"
           exit 1
       fi
   fi
fi

if (( $GUI > 0 )) then
    echo "set GUI 1" > args.tcl
    xsim attn_head_tb -gui -t xsim.tcl
else
    echo "set GUI 0" > args.tcl
    xsim attn_head_tb -t xsim.tcl
fi
