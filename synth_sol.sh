#!/bin/zsh

CLEANUP=$1
FUNCSIM=$2
USE_SYNTH_ALL=$3
USE_SYNTH_SYSTOLIC=$4
USE_SYNTH_SOFTMAX=$5
USE_SYNTH_LN=$6
USE_SYNTH_GELU=$7

if [[ $CLEANUP -eq 0 ]]; then
    if [[ $USE_SYNTH_ALL -eq 1 || $USE_SYNTH_SYSTOLIC -eq 1 ]]; then
        [[ -e systolic_temp.sv ]] || cp systolic.sv systolic_temp.sv;
        [[ -e mm_pp_blocked_A_temp.sv ]] || cp mm_pp_blocked_A.sv mm_pp_blocked_A_temp.sv;
        [[ -e mm_pp_temp.sv ]] || cp mm_pp.sv mm_pp_temp.sv;
        [[ -e mm_temp.sv ]] || cp mm.sv mm_temp.sv;

        if [[ $FUNCSIM -eq 1 ]]; then
            cp -f systolic_func_sol.sv systolic.sv;
        else
            cp -f systolic_synth_sol.sv systolic.sv;
        fi
        cp -f mm_pp_blocked_A_synth_sol.sv mm_pp_blocked_A.sv;
        cp -f mm_pp_synth_sol.sv mm_pp.sv;
        cp -f mm_synth_sol.sv mm.sv;
    fi
    if [[ $USE_SYNTH_ALL -eq 1 || $USE_SYNTH_SOFTMAX -eq 1 ]]; then
        [[ -e softmax_temp.sv ]] || cp softmax.sv softmax_temp.sv
        [[ -e softmax_top_temp.sv ]] || cp softmax_top.sv softmax_top_temp.sv

        if [[ $FUNCSIM -eq 1 ]]; then
            cp -f softmax_func_sol.sv softmax.sv;
        else
            cp -f softmax_synth_sol.sv softmax.sv;
        fi
        cp -f softmax_top_synth_sol.sv softmax_top.sv;
    fi
    if [[ $USE_SYNTH_ALL -eq 1 || $USE_SYNTH_LN -eq 1 ]]; then
        [[ -e layer_norm_temp.sv ]] || cp layer_norm.sv layer_norm_temp.sv
        [[ -e layer_norm_top_temp.sv ]] || cp layer_norm_top.sv layer_norm_top_temp.sv

        if [[ $FUNCSIM -eq 1 ]]; then
            cp -f layer_norm_func_sol.sv layer_norm.sv;
        else
            cp -f layer_norm_synth_sol.sv layer_norm.sv;
        fi
        cp -f layer_norm_top_synth_sol.sv layer_norm_top.sv;
    fi
    if [[ $USE_SYNTH_ALL -eq 1 || $USE_SYNTH_GELU -eq 1 ]]; then
        [[ -e gelu_temp.sv ]] || cp gelu.sv gelu_temp.sv
        [[ -e gelu_top_temp.sv ]] || cp gelu_top.sv gelu_top_temp.sv

        if [[ $FUNCSIM -eq 1 ]]; then
            cp -f gelu_func_sol.sv gelu.sv;
        else
            cp -f gelu_synth_sol.sv gelu.sv;
        fi
        cp -f gelu_top_synth_sol.sv gelu_top.sv;
    fi
else # $CLEANUP -eq 1
    for f in *_temp.sv(N); do
        mv "$f" "${f/_temp.sv/.sv}";
    done
fi
