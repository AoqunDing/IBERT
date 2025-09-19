#!/bin/zsh

USE_BOARD=$1
PYNQ_IP=$2

USE_SYNTH_ALL=0
USE_SYNTH_SYSTOLIC=0
USE_SYNTH_SOFTMAX=0
USE_SYNTH_LN=0
USE_SYNTH_GELU=0
if grep -qEv '^\s*USE_SYNTH[A-Za-z0-9_]*=(0|1)\s*$' synth_config.sh; then
    echo "Invalid lines in synth_config.sh, only USE_SYNTH* assignments allowed."
    return 1
fi
source synth_config.sh

DIR=~/ece327-w25/labs-admin/lab5-sol
cp $DIR/Makefile .
cp $DIR/*.sh .
cp $DIR/*.tcl .
cp $DIR/*_tb.sv .
cp $DIR/*_vtb.sv .
cp $DIR/*.py .
cp $DIR/*.cpp .
cp $DIR/*.xdc .
cp $DIR/*.golden .
cp $DIR/*dims.sv .

#rm -Rf data
#rm -Rf unisims
#ln -s $DIR/../lab5-data data
#ln -s $DIR/../unisims unisims

make reallyclean

extra_files=""
if [[ $USE_SYNTH_ALL -eq 1 || $USE_SYNTH_SYSTOLIC -eq 1 || $USE_SYNTH_SOFTMAX -eq 1 || $USE_SYNTH_LN -eq 1 || $USE_SYNTH_GELU -eq 1 ]]; then
    extra_files="unisims/*.v lint.vlt"
fi

zsh synth_sol.sh 0 1 ${USE_SYNTH_ALL} ${USE_SYNTH_SYSTOLIC} ${USE_SYNTH_SOFTMAX} ${USE_SYNTH_LN} ${USE_SYNTH_GELU}

# Lint
echo "Lint check on attn_head.sv..."
eval verilator -Wall -Wno-WIDTHEXPAND -Wno-WIDTHTRUNC -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-IMPORTSTAR -Wno-PINCONNECTEMPTY -Wno-GENUNNAMED -Wno-DECLFILENAME -Wno-EOFNEWLINE -Wno-TIMESCALEMOD -Wno-width -Wno-unused --lint-only --no-timing -DPING_PONG -DONESYS -GN1=4 -GN2=4 -GMATRIXSIZE_W=24 -GsN1=4 -GsN2=4 -GMEM_DEPTH_Q=512 -GMEM_DEPTH_K=512 -GMEM_DEPTH_S=256 -GMEM_DEPTH_A=6144 -GMEM_DEPTH_B=1536 -GMEM_DEPTH_D=512 -DDIR="\"tb_head/\"" dims.sv attn_head.sv $extra_files 2>&1 | tee grade_lint_attn.txt
lint_attn_head=`grep "Error" grade_lint_attn.txt | wc -l`

echo "Lint check on mm_ln.sv..."
eval verilator -Wall -Wno-WIDTHEXPAND -Wno-WIDTHTRUNC -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-IMPORTSTAR -Wno-PINCONNECTEMPTY -Wno-GENUNNAMED -Wno-DECLFILENAME -Wno-EOFNEWLINE -Wno-TIMESCALEMOD -Wno-width -Wno-unused --lint-only --no-timing -DPING_PONG -DONESYS -GN1=4 -GN2=4 -GMATRIXSIZE_W=24 -GMAT_ADD_MEM_DEPTH=24576 -GMEM_DEPTH_A=6144 -GMEM_DEPTH_B=768 -GMEM_DEPTH_D=6144 -DDIR="\"tb_self/\"" dims.sv mm_ln.sv $extra_files 2>&1 | tee grade_lint_self_out.txt
lint_mm_ln=`grep "Error" grade_lint_self_out.txt | wc -l`

echo "Lint check on mm_gelu.sv..."
eval verilator -Wall -Wno-WIDTHEXPAND -Wno-WIDTHTRUNC -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM -Wno-IMPORTSTAR -Wno-PINCONNECTEMPTY -Wno-GENUNNAMED -Wno-DECLFILENAME -Wno-EOFNEWLINE -Wno-TIMESCALEMOD -Wno-width -Wno-unused --lint-only --no-timing -DPING_PONG -DONESYS -GN1=4 -GN2=4 -GMATRIXSIZE_W=24 -GMEM_DEPTH_A=6144 -GMEM_DEPTH_B=6144 -GMEM_DEPTH_D=24576 -GBLOCKED_D=1 -DDIR="\"tb_inter/\"" dims.sv mm_gelu.sv $extra_files 2>&1 | tee grade_lint_inter.txt
lint_mm_gelu=`grep "Error" grade_lint_inter.txt | wc -l`

# Lint Grades
if [[ $lint_attn_head -eq 0 ]]; then lint_attn_head=2; else lint_attn_head=0; fi
if [[ $lint_mm_ln -eq 0 ]]; then lint_mm_ln=2; else lint_mm_ln=0; fi
if [[ $lint_mm_gelu -eq 0 ]]; then lint_mm_gelu=2; else lint_mm_gelu=0; fi

# Simulation
attn_sim=0
make attn_head_tb.sv M1=32 M2=768 M3=64 HEADS=12 USE_SYNTH=$USE_SYNTH_ALL USE_SYNTH_SYSTOLIC=$USE_SYNTH_SYSTOLIC USE_SYNTH_SOFTMAX=$USE_SYNTH_SOFTMAX  USE_SYNTH_LN=$USE_SYNTH_LN USE_SYNTH_GELU=$USE_SYNTH_GELU 2>&1 | tee grade_attn.txt
attn_err=`grep "HISSSSS" grade_attn.txt | wc -l`
attn_pass=`grep "Thank Mr. Goose" grade_attn.txt | wc -l`
if [[ $attn_err -eq 0 && $attn_pass -eq 12 ]]; then attn_sim=10; fi

self_out_sim=0
make mm_ln_tb.sv M1=32 M2=768 M3=768 BLOCKS=192 USE_SYNTH=$USE_SYNTH_ALL USE_SYNTH_SYSTOLIC=$USE_SYNTH_SYSTOLIC USE_SYNTH_SOFTMAX=$USE_SYNTH_SOFTMAX  USE_SYNTH_LN=$USE_SYNTH_LN USE_SYNTH_GELU=$USE_SYNTH_GELU 2>&1 | tee grade_self_out.txt
self_out_err=`grep "HISSSSS" grade_self_out.txt | wc -l`
self_out_pass=`grep "Thank Mr. Goose" grade_self_out.txt | wc -l`
if [[ $self_out_err -eq 0 && $self_out_pass -eq 1 ]]; then self_out_sim=10; fi

inter_sim=0
make mm_gelu_tb.sv M1=32 M2=768 M3=3072 BLOCKS=96 BLOCKED_D=1 USE_SYNTH=$USE_SYNTH_ALL USE_SYNTH_SYSTOLIC=$USE_SYNTH_SYSTOLIC USE_SYNTH_SOFTMAX=$USE_SYNTH_SOFTMAX  USE_SYNTH_LN=$USE_SYNTH_LN USE_SYNTH_GELU=$USE_SYNTH_GELU 2>&1 | tee grade_inter.txt
inter_err=`grep "HISSSSS" grade_inter.txt | wc -l`
inter_pass=`grep "Thank Mr. Goose" grade_inter.txt | wc -l`
if [[ $inter_err -eq 0 && $inter_pass -eq 1 ]]; then inter_sim=10; fi

# All-layers IBERT simulation
ibert_sim=0
make clean
if [[ $attn_sim -gt 0 && $self_out_sim -gt 0 && $inter_sim -gt 0 ]]; then
    make ibert_axi_tb.sv BLOCKED_D=1 USE_SYNTH=$USE_SYNTH_ALL USE_SYNTH_SYSTOLIC=$USE_SYNTH_SYSTOLIC USE_SYNTH_SOFTMAX=$USE_SYNTH_SOFTMAX  USE_SYNTH_LN=$USE_SYNTH_LN USE_SYNTH_GELU=$USE_SYNTH_GELU 2>&1 | tee grade_ibert.txt
    ibert_err=`grep "HISSSSS" grade_ibert.txt | wc -l`
    ibert_pass=`grep "Thank Mr. Goose" grade_ibert.txt | wc -l`
    if [[ $ibert_err -eq 0 && $ibert_pass -eq 15 ]]; then ibert_sim=10; fi
fi

zsh synth_sol.sh 0 0 ${USE_SYNTH_ALL} ${USE_SYNTH_SYSTOLIC} ${USE_SYNTH_SOFTMAX} ${USE_SYNTH_LN} ${USE_SYNTH_GELU}

# Synthesis Timing, Resources
mm_ln_synth_timing=0
mm_ln_synth_util=0
if [[ $self_out_sim -gt 0 ]]; then
    make synth TG=mm_ln M1=32 M2=768 M3=768 BLOCKS=192
    if [ -e "mm_ln_synth.sv" ]; then
        if [ -e "mm_ln_synth_timing.txt" ]; then
            mm_ln_synth_timing_met=`grep "MET" mm_ln_synth_timing.txt | wc -l`
            mm_ln_synth_slack=`cat mm_ln_synth_timing.txt | grep Slack | cut -d" " -f11 | cut -d"n" -f1`
            if [[ $mm_ln_synth_timing_met -eq 1 || $mm_ln_synth_slack -gt -0.3 ]]; then mm_ln_synth_timing=2; else mm_ln_synth_timing=0; fi
        fi

        if [ -e "mm_ln_synth_util.txt" ]; then
            mm_ln_synth_gold_lut=`cat mm_ln_synth_util.golden | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_ln_synth_gold_ff=`cat mm_ln_synth_util.golden | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_ln_synth_gold_dsp=`cat mm_ln_synth_util.golden | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_ln_synth_lut=`cat mm_ln_synth_util.txt | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_ln_synth_ff=`cat mm_ln_synth_util.txt | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g | head -1`
            mm_ln_synth_dsp=`cat mm_ln_synth_util.txt | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_ln_diff_lut=`expr 100 \* \( $mm_ln_synth_lut - $mm_ln_synth_gold_lut \) \/ $mm_ln_synth_gold_lut`
            mm_ln_diff_ff=`expr 100 \* \( $mm_ln_synth_ff - $mm_ln_synth_gold_ff \) \/ $mm_ln_synth_gold_ff`
            mm_ln_diff_dsp=`expr 100 \* \( $mm_ln_synth_dsp - $mm_ln_synth_gold_dsp \) \/ $mm_ln_synth_gold_dsp`

            if [[ $mm_ln_synth_lut -eq 0 || $mm_ln_synth_ff -eq 0 || $mm_ln_diff_lut -gt 30 || $mm_ln_diff_ff -gt 30 || $mm_ln_diff_dsp -gt 30 ]]; then mm_ln_synth_util=0; else mm_ln_synth_util=2; fi
        fi
    fi
fi

mm_gelu_synth_timing=0
mm_gelu_synth_util=0
if [[ $inter_sim -gt 0 ]]; then
    make synth TG=mm_gelu M1=32 M2=768 M3=3072 BLOCKS=96 BLOCKED_D=1
    if [ -e "mm_gelu_synth.sv" ]; then
        if [ -e "mm_gelu_synth_timing.txt" ]; then
            mm_gelu_synth_timing_met=`grep "MET" mm_gelu_synth_timing.txt | wc -l`
            mm_gelu_slack=`grep "slack" mm_gelu_synth_timing.txt | tr -s " " | cut -d" " -f3`
            if [[ $mm_gelu_synth_timing_met -eq 1 || $mm_gelu_slack -gt -0.3 ]]; then mm_gelu_synth_timing=2; else mm_gelu_synth_timing=0; fi
        fi

        if [ -e "mm_gelu_synth_util.txt" ]; then
            mm_gelu_synth_gold_lut=`cat mm_gelu_synth_util.golden | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_gelu_synth_gold_ff=`cat mm_gelu_synth_util.golden | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_gelu_synth_gold_dsp=`cat mm_gelu_synth_util.golden | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_gelu_synth_lut=`cat mm_gelu_synth_util.txt | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_gelu_synth_ff=`cat mm_gelu_synth_util.txt | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g | head -1`
            mm_gelu_synth_dsp=`cat mm_gelu_synth_util.txt | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_gelu_diff_lut=`expr 100 \* \( $mm_gelu_synth_lut - $mm_gelu_synth_gold_lut \) \/ $mm_gelu_synth_gold_lut`
            mm_gelu_diff_ff=`expr 100 \* \( $mm_gelu_synth_ff - $mm_gelu_synth_gold_ff \) \/ $mm_gelu_synth_gold_ff`
            mm_gelu_diff_dsp=`expr 100 \* \( $mm_gelu_synth_dsp - $mm_gelu_synth_gold_dsp \) \/ $mm_gelu_synth_gold_dsp`

            if [[ $mm_gelu_synth_lut -eq 0 || $mm_gelu_synth_ff -eq 0 || $mm_gelu_diff_lut -gt 30 || $mm_gelu_diff_ff -gt 30 || $mm_gelu_diff_dsp -gt 30 ]]; then mm_gelu_synth_util=0; else mm_gelu_synth_util=2; fi
        fi
    fi
fi

attn_head_synth_timing=0
attn_head_synth_util=0
if [[ $attn_sim -gt 0 ]]; then
    make synth TG=attn_head M1=32 M2=768 M3=64 HEADS=1
    if [ -e "attn_head_synth.sv" ]; then
        if [ -e "attn_head_synth_timing.txt" ]; then
            attn_head_synth_timing_met=`grep "MET" attn_head_synth_timing.txt | wc -l`
            attn_head_synth_slack=`grep "slack" attn_head_synth_timing.txt | tr -s " " | cut -d" " -f3`
            if [[ $attn_head_synth_timing_met -eq 1 || $attn_head_synth_slack -gt -0.3 ]]; then attn_head_synth_timing=2; else attn_head_synth_timing=0; fi
        fi

        if [ -e "attn_head_synth_util.txt" ]; then
            attn_head_synth_gold_lut=`cat attn_head_synth_util.golden | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            attn_head_synth_gold_ff=`cat attn_head_synth_util.golden | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            attn_head_synth_gold_dsp=`cat attn_head_synth_util.golden | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            attn_head_synth_lut=`cat attn_head_synth_util.txt | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            attn_head_synth_ff=`cat attn_head_synth_util.txt | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g | head -1`
            attn_head_synth_dsp=`cat attn_head_synth_util.txt | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            attn_head_synth_diff_lut=`expr 100 \* \( $attn_head_synth_lut - $attn_head_synth_gold_lut \) \/ $attn_head_synth_gold_lut`
            attn_head_synth_diff_ff=`expr 100 \* \( $attn_head_synth_ff - $attn_head_synth_gold_ff \) \/ $attn_head_synth_gold_ff`
            attn_head_synth_diff_dsp=`expr 100 \* \( $attn_head_synth_dsp - $attn_head_synth_gold_dsp \) \/ $attn_head_synth_gold_dsp`

            if [[ $attn_head_synth_lut -eq 0 || $attn_head_synth_ff -eq 0 || $attn_head_synth_diff_lut -gt 30 || $attn_head_synth_diff_ff -gt 30 || $attn_head_synth_diff_dsp -gt 30 ]]; then attn_head_synth_util=0; else attn_head_synth_util=2; fi
        fi
    fi
fi

# Implementation Timing, Resources
mm_ln_impl_timing=0
mm_ln_impl_util=0
if [[ $self_out_sim -gt 0 ]]; then
    make impl TG=mm_ln M1=32 M2=768 M3=768 BLOCKS=192
    if [ -e "mm_ln_impl.sv" ]; then
        if [ -e "mm_ln_impl_timing.txt" ]; then
            mm_ln_impl_timing_met=`grep "MET" mm_ln_impl_timing.txt | wc -l`
            mm_ln_impl_slack=`cat mm_ln_impl_timing.txt | grep Slack | cut -d" " -f11 | cut -d"n" -f1`
            if [[ $mm_ln_impl_timing_met -eq 1 || $mm_ln_impl_slack -gt -0.3 ]]; then mm_ln_impl_timing=2; else mm_ln_impl_timing=0; fi
        fi

        if [ -e "mm_ln_impl_util.txt" ]; then
            mm_ln_impl_gold_lut=`cat mm_ln_impl_util.golden | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_ln_impl_gold_ff=`cat mm_ln_impl_util.golden | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_ln_impl_gold_dsp=`cat mm_ln_impl_util.golden | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_ln_impl_lut=`cat mm_ln_impl_util.txt | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_ln_impl_ff=`cat mm_ln_impl_util.txt | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g | head -1`
            mm_ln_impl_dsp=`cat mm_ln_impl_util.txt | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_ln_diff_lut=`expr 100 \* \( $mm_ln_impl_lut - $mm_ln_impl_gold_lut \) \/ $mm_ln_impl_gold_lut`
            mm_ln_diff_ff=`expr 100 \* \( $mm_ln_impl_ff - $mm_ln_impl_gold_ff \) \/ $mm_ln_impl_gold_ff`
            mm_ln_diff_dsp=`expr 100 \* \( $mm_ln_impl_dsp - $mm_ln_impl_gold_dsp \) \/ $mm_ln_impl_gold_dsp`

            if [[ $mm_ln_impl_lut -eq 0 || $mm_ln_impl_ff -eq 0 || $mm_ln_diff_lut -gt 30 || $mm_ln_diff_ff -gt 30 || $mm_ln_diff_dsp -gt 30 ]]; then mm_ln_impl_util=0; else mm_ln_impl_util=2; fi
        fi
    fi
fi

mm_gelu_impl_timing=0
mm_gelu_impl_util=0
if [[ $inter_sim -gt 0 ]]; then
    make impl TG=mm_gelu M1=32 M2=768 M3=3072 BLOCKS=96 BLOCKED_D=1
    if [ -e "mm_gelu_impl.sv" ]; then
        if [ -e "mm_gelu_impl_timing.txt" ]; then
            mm_gelu_impl_timing_met=`grep "MET" mm_gelu_impl_timing.txt | wc -l`
            mm_gelu_slack=`grep "slack" mm_gelu_impl_timing.txt | tr -s " " | cut -d" " -f3`
            if [[ $mm_gelu_impl_timing_met -eq 1 || $mm_gelu_slack -gt -0.3 ]]; then mm_gelu_impl_timing=2; else mm_gelu_impl_timing=0; fi
        fi

        if [ -e "mm_gelu_impl_util.txt" ]; then
            mm_gelu_impl_gold_lut=`cat mm_gelu_impl_util.golden | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_gelu_impl_gold_ff=`cat mm_gelu_impl_util.golden | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_gelu_impl_gold_dsp=`cat mm_gelu_impl_util.golden | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_gelu_impl_lut=`cat mm_gelu_impl_util.txt | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            mm_gelu_impl_ff=`cat mm_gelu_impl_util.txt | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g | head -1`
            mm_gelu_impl_dsp=`cat mm_gelu_impl_util.txt | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            mm_gelu_diff_lut=`expr 100 \* \( $mm_gelu_impl_lut - $mm_gelu_impl_gold_lut \) \/ $mm_gelu_impl_gold_lut`
            mm_gelu_diff_ff=`expr 100 \* \( $mm_gelu_impl_ff - $mm_gelu_impl_gold_ff \) \/ $mm_gelu_impl_gold_ff`
            mm_gelu_diff_dsp=`expr 100 \* \( $mm_gelu_impl_dsp - $mm_gelu_impl_gold_dsp \) \/ $mm_gelu_impl_gold_dsp`

            if [[ $mm_gelu_impl_lut -eq 0 || $mm_gelu_impl_ff -eq 0 || $mm_gelu_diff_lut -gt 30 || $mm_gelu_diff_ff -gt 30 || $mm_gelu_diff_dsp -gt 30 ]]; then mm_gelu_impl_util=0; else mm_gelu_impl_util=2; fi
        fi
    fi
fi

attn_head_impl_timing=0
attn_head_impl_util=0
if [[ $attn_sim -gt 0 ]]; then
    make impl TG=attn_head M1=32 M2=768 M3=64 HEADS=1
    if [ -e "attn_head_impl.sv" ]; then
        if [ -e "attn_head_impl_timing.txt" ]; then
            attn_head_impl_timing_met=`grep "MET" attn_head_impl_timing.txt | wc -l`
            attn_head_impl_slack=`grep "slack" attn_head_impl_timing.txt | tr -s " " | cut -d" " -f3`
            if [[ $attn_head_impl_timing_met -eq 1 || $attn_head_impl_slack -gt -0.3 ]]; then attn_head_impl_timing=2; else attn_head_impl_timing=0; fi
        fi

        if [ -e "attn_head_impl_util.txt" ]; then
            attn_head_impl_gold_lut=`cat attn_head_impl_util.golden | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            attn_head_impl_gold_ff=`cat attn_head_impl_util.golden | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            attn_head_impl_gold_dsp=`cat attn_head_impl_util.golden | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            attn_head_impl_lut=`cat attn_head_impl_util.txt | grep "Slice LUTs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`
            attn_head_impl_ff=`cat attn_head_impl_util.txt | grep "Slice Registers" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g | head -1`
            attn_head_impl_dsp=`cat attn_head_impl_util.txt | grep "DSPs" | head -n 1 | cut -d"|" -f 3 | sed s/\ //g`

            attn_head_impl_diff_lut=`expr 100 \* \( $attn_head_impl_lut - $attn_head_impl_gold_lut \) \/ $attn_head_impl_gold_lut`
            attn_head_impl_diff_ff=`expr 100 \* \( $attn_head_impl_ff - $attn_head_impl_gold_ff \) \/ $attn_head_impl_gold_ff`
            attn_head_impl_diff_dsp=`expr 100 \* \( $attn_head_impl_dsp - $attn_head_impl_gold_dsp \) \/ $attn_head_impl_gold_dsp`

            if [[ $attn_head_impl_lut -eq 0 || $attn_head_impl_ff -eq 0 || $attn_head_impl_diff_lut -gt 30 || $attn_head_impl_diff_ff -gt 30 || $attn_head_impl_diff_dsp -gt 30 ]]; then attn_head_impl_util=0; else attn_head_impl_util=2; fi
        fi
    fi
fi

# Grade board
if [[ $USE_BOARD -eq 1 && $ibert_sim -gt 0 ]]; then
    make prep-board
    make grade-board PYNQ_IP=$PYNQ_IP
fi

# Grades
rm -f grade.csv
#lint
echo "$lint_attn_head,$lint_mm_ln,$lint_mm_gelu" >> grade.csv
#sim
echo "$attn_sim,$self_out_sim,$inter_sim,$ibert_sim" >> grade.csv
#synth timing
echo "$mm_ln_synth_timing,$mm_gelu_synth_timing,$attn_head_synth_timing" >> grade.csv
#synth util
echo "$mm_ln_synth_util,$mm_gelu_synth_util,$attn_head_synth_util" >> grade.csv
#impl timing
echo "$mm_ln_impl_timing,$mm_gelu_impl_timing,$attn_head_impl_timing" >> grade.csv
#impl util
echo "$mm_ln_impl_util,$mm_gelu_impl_util,$attn_head_impl_util" >> grade.csv


if [ -e "grade_board.csv" ]; then
    cat grade_board.csv >> grade.csv
fi
