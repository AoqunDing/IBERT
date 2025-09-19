#!/bin/zsh

PYNQ_IP=pynq-lab-10.eng.uwaterloo.ca
if [[ -n $1 ]]; then
    PYNQ_IP=$1
fi
rpt_file=ibert_overlay/tutorial/tutorial.runs/impl_1/tutorial_wrapper_timing_summary_routed.rpt

slack=0
if [[ -f ${rpt_file} ]] then
    if grep -q "Slack (VIOLATED) :" ${rpt_file}; then
        slack=0
    else
        slack=6
    fi
fi
echo "$slack" > grade_board.csv

if [ -e "ibert_overlay/tutorial_4_4.bit" ]; then
    make board TG=ibert PYNQ_IP=${PYNQ_IP} | tee board.txt
    board=`cat board.txt | grep "Thank Mr. Goose" | wc -l`
else
    echo "Error: Can not find bitstream file ibert_overlay/tutorial_4_4.bit. Make sure to run make prep-board first."
    board=0
fi

rm -f grade_board.csv
echo "$slack,$board" >> grade_board.csv

# mm_ln_board_grade=0
# mm_gelu_board_grade=0
# mm_ln_slack_grade=0
# mm_gelu_slack_grade=0


# ## mm_ln board test
# if [ -e "mm_ln_overlay/tutorial_4_4.bit" ]; then
#     make mm-ln-board M1=32 M2=4 M3=768 N1=4 N2=4 PYNQ_IP=${PYNQ_IP} | tee mm_ln_board.txt
#     mm_ln_board=`cat mm_ln_board.txt | grep "Thank Mr. Goose" | wc -l`
# else 
#     echo "Error: Can not find bitstream file mm_ln_overlay/tutorial_4_4.bit for 'make mm-ln-board M1=32 M2=4 M3=768 N1=4 N2=4'"
#     mm_ln_board=0
# fi

# if [[ $mm_ln_board -gt 1 ]]; then mm_ln_board_grade=6; else mm_ln_board_grade=0; fi

# if [ -e "mm_gelu_overlay/tutorial_4_4.bit" ]; then
#     make mm-gelu-board M1=4 M2=4 M3=768 N1=4 N2=4 PYNQ_IP=${PYNQ_IP} | tee mm_gelu_board.txt
#     mm_gelu_board=`cat mm_gelu_board.txt | grep "Thank Mr. Goose" | wc -l`
# else 
#     echo "Error: Can not find bitstream file mm_gelu_overlay/tutorial_4_4.bit for 'make mm-gelu-board M1=4 M2=4 M3=768 N1=4 N2=4'"
#     mm_gelu_board=0
# fi

# if [[ $mm_gelu_board -gt 1 ]]; then mm_gelu_board_grade=6; else mm_gelu_board_grade=0; fi


# ## slack checks

# ## mm_ln grade timing
# mm_ln_timing_rpt=mm_ln_overlay/tutorial/tutorial.runs/impl_1/tutorial_wrapper_timing_summary_routed.rpt
# mm_ln_timing_opt_rpt=mm_ln_overlay/tutorial/tutorial.runs/impl_1/tutorial_wrapper_timing_summary_postroute_physopted.rpt

# cat ${mm_ln_timing_rpt} | grep clk_fpga_0 | head -n 2 > mm_ln_bitstream_timing.txt
# mm_ln_slack=`cat mm_ln_bitstream_timing.txt | tail -n 1 | sed "s/\ \+/\ /g" | cut -d" " -f2`

# if [[ -f ${mm_ln_timing_opt_rpt} ]] then
#     cat ${mm_ln_timing_opt_rpt} | grep clk_fpga_0 | head -n 2 > mm_ln_bitstream_timing_opt.txt
#     mm_ln_slack_opt=`cat mm_ln_bitstream_timing_opt.txt | tail -n 1 | sed "s/\ \+/\ /g" | cut -d" " -f2`

#     if (( $mm_ln_slack_opt > $mm_ln_slack )) then
#         mm_ln_slack=$mm_ln_slack_opt
#     fi
# fi

# if (( $mm_ln_slack > -0.3 )); then mm_ln_slack_grade=4; else mm_ln_slack_grade=0; fi

# # mm_gelu board
# mm_gelu_timing_rpt=mm_gelu_overlay/tutorial/tutorial.runs/impl_1/tutorial_wrapper_timing_summary_routed.rpt
# mm_gelu_timing_opt_rpt=mm_gelu_overlay/tutorial/tutorial.runs/impl_1/tutorial_wrapper_timing_summary_postroute_physopted.rpt

# cat ${mm_gelu_timing_rpt} | grep clk_fpga_0 | head -n 2 > mm_gelu_bitstream_timing.txt
# mm_gelu_slack=`cat mm_gelu_bitstream_timing.txt | tail -n 1 | sed "s/\ \+/\ /g" | cut -d" " -f2`

# if [[ -f ${mm_gelu_timing_opt_rpt} ]] then
#     cat ${mm_gelu_timing_opt_rpt} | grep clk_fpga_0 | head -n 2 > mm_gelu_bitstream_timing_opt.txt
#     mm_gelu_slack_opt=`cat mm_gelu_bitstream_timing_opt.txt | tail -n 1 | sed "s/\ \+/\ /g" | cut -d" " -f2`

#     if (( $mm_gelu_slack_opt > $mm_gelu_slack )) then
#         mm_gelu_slack=$mm_gelu_slack_opt
#     fi
# fi

# if (( $mm_gelu_slack > -0.3 )); then mm_gelu_slack_grade=4; else mm_gelu_slack_grade=0; fi

# echo "$mm_ln_slack_grade,$mm_gelu_slack_grade" > grade_board.csv
# echo "$mm_ln_board_grade,$mm_gelu_board_grade" >> grade_board.csv
