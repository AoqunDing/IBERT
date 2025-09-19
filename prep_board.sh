#!/bin/zsh

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

make bitstream TG=ibert USE_SYNTH=$USE_SYNTH_ALL USE_SYNTH_SYSTOLIC=$USE_SYNTH_SYSTOLIC USE_SYNTH_SOFTMAX=$USE_SYNTH_SOFTMAX USE_SYNTH_LN=$USE_SYNTH_LN USE_SYNTH_GELU=$USE_SYNTH_GELU
# make board-data
# make ibert-board-weights
