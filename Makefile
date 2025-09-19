PYNQ_IP ?= pynq-lab-10.eng.uwaterloo.ca
GUI ?= 0
MODE ?=
USE_BOARD ?= 0
TRACE ?= 0
TIMING ?= 0
TIMEOUT ?= 1
TB ?= $(basename $(firstword ${MAKECMDGOALS}))
TG ?= $(patsubst %_tb,%,$(patsubst %_axi_tb,%,$(patsubst %_on_axis_tb,%,${TB})))
SRC = ${shell cat ${TB}.f}
SIM ?= verilator
USE_SYNTH ?= 0
USE_SYNTH_SYSTOLIC ?= 0
USE_SYNTH_SOFTMAX ?= 0
USE_SYNTH_LN ?= 0
USE_SYNTH_GELU ?= 0
UNISIMS=

M1 ?= 32
M2 ?= 768
M3 ?= 768
N ?= 4
sN ?= 4
N1 ?= ${N}
N2 ?= ${N}
sN1 ?= ${sN}
sN2 ?= ${sN}
BLOCKS ?= 8
PING_PONG ?= 0
MATRIXSIZE_W ?= 24
ONESYS ?= 1
HEAD ?= 0
HEADS ?= 12
DEBUG ?= 0
LAYER ?= 0
DATA ?= 1
REUSE ?= 1
KEEP_A ?= 1
READ_A ?= 0
BLOCKED_A ?= 0
BLOCKED_D ?= 0
BLOCKS_D ?= 1
SLICES ?= 1
eM1 = $(shell python3 -c "print(int(${M1}/${SLICES}))")
eREUSE = $(shell python3 -c "print(int(${REUSE}*${SLICES}))")
MEM_DEPTH_A = $(shell python3 -c "print(int(${eM1}*${M2}/${N1}))")
MEM_DEPTH_B = $(shell python3 -c "print(int(${M2}*${M3}/(${N2}*${BLOCKS})))")
MEM_DEPTH_D = $(shell python3 -c "print(int(${eM1}*${M3}/${N1}))")
MEM_DEPTH_Q = $(shell python3 -c "print(int(${eM1}*${M3}/${sN1}))")
MEM_DEPTH_K = $(shell python3 -c "print(int(${eM1}*${M3}/${sN2}))")
MEM_DEPTH_S = $(shell python3 -c "print(int(${eM1}*${eM1}/${sN1}))")
MAT_ADD_MEM_DEPTH = $(shell python3 -c "print(int(${eM1}*${M3}))")

VFLAGS := --build
VFLAGS += --exe
VFLAGS += --cc
VFLAGS += --no-std
VFLAGS += --unroll-count 1024
VFLAGS += -Wall
# VFLAGS += -Wno-COMBDLY
VFLAGS += -Wno-WIDTHEXPAND
VFLAGS += -Wno-WIDTHTRUNC
VFLAGS += -Wno-UNUSEDSIGNAL
VFLAGS += -Wno-UNUSEDPARAM
VFLAGS += -Wno-IMPORTSTAR
VFLAGS += -Wno-PINCONNECTEMPTY
VFLAGS += -Wno-GENUNNAMED
VFLAGS += -Wno-DECLFILENAME
VFLAGS += -GN1=${N1}
VFLAGS += -GN2=${N2}
VFLAGS += -GMATRIXSIZE_W=${MATRIXSIZE_W}

XELAB_FLAGS := --O3
XELAB_FLAGS += --generic_top "N1=${N1}"
XELAB_FLAGS += --generic_top "N2=${N2}"
XELAB_FLAGS += --generic_top "MATRIXSIZE_W=${MATRIXSIZE_W}"
XELAB_FLAGS += -debug off

XELAB_SYNTH_FLAGS := -maxdelay
XELAB_SYNTH_FLAGS += -L secureip
XELAB_SYNTH_FLAGS += -L simprims_ver
XELAB_SYNTH_FLAGS += -transport_int_delays
XELAB_SYNTH_FLAGS += -pulse_r 0
XELAB_SYNTH_FLAGS += -pulse_int_r 0

XSIM_FLAGS :=
XVLOG_FLAGS :=
MVLOG_FLAGS :=

VIVADO_FLAGS := -nolog
VIVADO_FLAGS := -nojournal
VIVADO_FLAGS := -notrace
VIVADO_FLAGS := -mode tcl

DEFINES =

BIT_FILE ?= tutorial_${N1}_${N2}
BOARD_DEPS = ${OVERLAY_DIR}/${BIT_FILE}.bit ${OVERLAY_DIR}/${BIT_FILE}.hwh
BOARD_DEPS += board-bits
RUN_DEPS =

ifeq (${TG},attn_head)
VFLAGS += -GsN1=${sN1}
VFLAGS += -GsN2=${sN2}
VFLAGS += -GMEM_DEPTH_Q=${MEM_DEPTH_Q}
VFLAGS += -GMEM_DEPTH_K=${MEM_DEPTH_K}
VFLAGS += -GMEM_DEPTH_S=${MEM_DEPTH_S}
VFLAGS += -GHEADS=${HEADS}
VFLAGS += -GLAYER=${LAYER}
else ifeq (${TG},mm_ln)
VFLAGS += -GMAT_ADD_MEM_DEPTH=${MAT_ADD_MEM_DEPTH}
VFLAGS += -GSLICES=${SLICES}
else ifeq (${TG},mm_gelu)
VFLAGS += -GLAYER=${LAYER}
VFLAGS += -GSLICES=${SLICES}
else ifeq (${TG},ibert)
VFLAGS += -GsN1=${sN1}
VFLAGS += -GsN2=${sN2}
VFLAGS += -GHEADS=${HEADS}
VFLAGS += -GSLICES=${SLICES}
endif

ifeq (${USE_SYNTH}, 1)
UNISIMS = unisims/*.v
else ifeq (${USE_SYNTH_SYSTOLIC}, 1)
UNISIMS = unisims/*.v
else ifeq (${USE_SYNTH_SOFTMAX}, 1)
UNISIMS = unisims/*.v
else ifeq (${USE_SYNTH_LN}, 1)
UNISIMS = unisims/*.v
else ifeq (${USE_SYNTH_GELU}, 1)
UNISIMS = unisims/*.v
endif

ifeq (${TG},ibert)
VFLAGS += -GREUSE=${REUSE}
XELAB_FLAGS += --generic_top "REUSE=${REUSE}"
XELAB_FLAGS += --generic_top "SLICES=${SLICES}"
else
VFLAGS += -GM1=${eM1}
VFLAGS += -GM2=${M2}
VFLAGS += -GM3=${M3}
VFLAGS += -GREUSE=${eREUSE}
VFLAGS += -GBLOCKS=${BLOCKS}
VFLAGS += -GMEM_DEPTH_A=${MEM_DEPTH_A}
VFLAGS += -GMEM_DEPTH_B=${MEM_DEPTH_B}
VFLAGS += -GMEM_DEPTH_D=${MEM_DEPTH_D}
XELAB_FLAGS += --generic_top "M1=${eM1}"
XELAB_FLAGS += --generic_top "M2=${M2}"
XELAB_FLAGS += --generic_top "M3=${M3}"
XELAB_FLAGS += --generic_top "REUSE=${eREUSE}"
XELAB_FLAGS += --generic_top "BLOCKS=${BLOCKS}"
XELAB_FLAGS += --generic_top "MEM_DEPTH_A=${MEM_DEPTH_A}"
XELAB_FLAGS += --generic_top "MEM_DEPTH_B=${MEM_DEPTH_B}"
XELAB_FLAGS += --generic_top "MEM_DEPTH_D=${MEM_DEPTH_D}"
endif

ifeq (${TG},attn_head)
XELAB_FLAGS += --generic_top "sN1=${sN1}"
XELAB_FLAGS += --generic_top "sN2=${sN2}"
XELAB_FLAGS += --generic_top "MEM_DEPTH_Q=${MEM_DEPTH_Q}"
XELAB_FLAGS += --generic_top "MEM_DEPTH_K=${MEM_DEPTH_K}"
XELAB_FLAGS += --generic_top "MEM_DEPTH_S=${MEM_DEPTH_S}"
XELAB_FLAGS += --generic_top "LAYER=${LAYER}"
XELAB_FLAGS += --generic_top "HEADS=${HEADS}"
else ifeq (${TG},mm_ln)
XELAB_FLAGS += --generic_top "MAT_ADD_MEM_DEPTH=${MAT_ADD_MEM_DEPTH}"
else ifeq (${TG},mm_gelu)
XELAB_FLAGS += --generic_top "LAYER=${LAYER}"
endif

ifeq (${TG},mm)
DATA_SCRIPT = mem.py
TEST_SCRIPT = test.py
BOARD_SCRIPT = board.py
VIVADO_SCRIPT = vivado.tcl
OVERLAY_DIR = overlay
TB_DIR = tb_mm
DATA_FLAGS = ${eM1} ${M2} ${M3} ${BLOCKS} ${eREUSE} ${KEEP_A} ${TB_DIR}
TEST_FLAGS = ${eM1} ${M2} ${M3} ${eREUSE} ${KEEP_A} ${BLOCKS_D} ${TB_DIR}
BOARD_FLAFS = ${M1} ${M2} ${M3} ${N1} ${N2} ${BLOCKS}
BIT_DEPS = args
else ifeq (${TG},attn_head)
DATA_SCRIPT = attn_head_mem.py
TEST_SCRIPT = attn_head_test.py
BOARD_SCRIPT = attn_head_board.py
VIVADO_SCRIPT = attn_head_vivado.tcl
OVERLAY_DIR = attn_head_overlay
DATA_DIR = heads
TB_DIR = tb_head
DATA_FLAGS = ${BLOCKS} ${REUSE} ${KEEP_A} ${HEADS} ${TB_DIR}
TEST_FLAGS = ${M1} ${M2} ${M3} ${REUSE} ${HEADS} ${TB_DIR}
BOARD_FLAFS = ${M1} ${M2} ${M3} ${N1} ${N2} ${BLOCKS} ${REUSE}
BOARD_DEPS += board-data
BIT_DEPS = args
else ifeq (${TG},mm_ln)
DATA_SCRIPT = mm_ln_mem.py
TEST_SCRIPT = mm_ln_test.py
BOARD_SCRIPT = mm_ln_board.py
VIVADO_SCRIPT = mm_ln_vivado.tcl
OVERLAY_DIR = mm_ln_overlay
ifeq (${M2},768)
DATA_DIR = self_out
TB_DIR = tb_self
else
DATA_DIR = layer_out
TB_DIR = tb_layer
endif
DATA_FLAGS = ${DATA_DIR} ${LAYER} ${BLOCKS} ${REUSE} ${SLICES} ${TB_DIR}
TEST_FLAGS = ${eM1} ${M2} ${M3} ${eREUSE} ${TB_DIR}
BOARD_FLAFS = ${eM1} ${M2} ${M3} ${N1} ${N2} ${BLOCKS} ${REUSE}
BOARD_DEPS += board-data
BIT_DEPS = args
else ifeq (${TG},mm_gelu)
DATA_SCRIPT = mm_gelu_mem.py
TEST_SCRIPT = mm_gelu_test.py
BOARD_SCRIPT = mm_gelu_board.py
VIVADO_SCRIPT = mm_gelu_vivado.tcl
OVERLAY_DIR = mm_gelu_overlay
DATA_DIR = inter
TB_DIR = tb_inter
DATA_FLAGS = ${DATA_DIR} ${LAYER} ${BLOCKS} ${REUSE} ${SLICES} ${TB_DIR}
TEST_FLAGS = ${eM1} ${M2} ${M3} ${eREUSE} ${BLOCKS_D} ${TB_DIR}
BOARD_FLAFS = ${eM1} ${M2} ${M3} ${N1} ${N2} ${BLOCKS} ${REUSE}
BOARD_DEPS += board-data
BIT_DEPS = args
else ifeq (${TG},ibert)
TB_DIR = tb_ibert
# BOARD_SCRIPT = ibert_board.py
BOARD_SCRIPT = ibert_on_board.py
BOARD_DEPS += board-data
OVERLAY_DIR = ibert_overlay
BOARD_FLAFS = ${N1} ${N2}
endif

VFLAGS += -DDIR="\"${TB_DIR}/\""
XVLOG_FLAGS += -d DIR="\"${TB_DIR}/\""
MVLOG_FLAGS += -define DIR="\"${TB_DIR}/\""

ifeq (${TIMING},1)
VFLAGS += --timing
VFLAGS += -CFLAGS -fcoroutines
else
VFLAGS += --no-timing
endif

ifeq (${TRACE},1)
VFLAGS += --trace-fst
VFLAGS += -DTRACE
XVLOG_FLAGS += -d TRACE
MVLOG_FLAGS += -define TRACE
endif

ifneq (${BLOCKS},1)
PING_PONG = 1
endif

ifeq (${PING_PONG},1)
VFLAGS += -DPING_PONG
XVLOG_FLAGS += -d PING_PONG
MVLOG_FLAGS += -define PING_PONG
DEFINES += PING_PONG
endif

ifeq (${ONESYS},1)
VFLAGS += -DONESYS
XVLOG_FLAGS += -d ONESYS
MVLOG_FLAGS += -define ONESYS
DEFINES += ONESYS
endif

ifeq (${READ_A},1)
VFLAGS += -DREAD_A
XVLOG_FLAGS += -d READ_A
MVLOG_FLAGS += -define READ_A
endif

ifeq (${BLOCKED_A},1)
VFLAGS += -GBLOCKED_A=${BLOCKED_A}
XELAB_FLAGS += --generic_top "BLOCKED_A=${BLOCKED_A}"
endif

ifeq (${BLOCKED_D},1)
BLOCKS_D = ${BLOCKS}
VFLAGS += -GBLOCKED_D=${BLOCKED_D}
XELAB_FLAGS += --generic_top "BLOCKED_D=${BLOCKED_D}"
endif

ifneq (${KEEP_A},1)
VFLAGS += -GKEEP_A=${KEEP_A}
XELAB_FLAGS += --generic_top "KEEP_A=${KEEP_A}"
endif

ifeq (${DATA},1)
ifeq (${TG},ibert)
RUN_DEPS += ibert-data
else
RUN_DEPS += data
endif
endif

ifeq (${TG},ibert)
RUN_DEPS += ibert-clean
endif

ifeq (${SIM},verilator)
RUN_DEPS += verilator
endif

ifeq (${SIM},xsim)
RUN_DEPS += xsim
endif

ifeq (${DEBUG},1)
VFLAGS += -DDEBUG
XVLOG_FLAGS += -d DEBUG
MVLOG_FLAGS += -define DEBUG
DEFINES += DEBUG
endif

ifeq (${MODE},synth)
XELAB_FLAGS += ${XELAB_SYNTH_FLAGS}
XELAB_FLAGS += glbl
XVLOG_FLAGS += -d XIL_TIMING
MVLOG_FLAGS += -define XIL_TIMING
endif

ifeq (${MODE},impl)
XELAB_FLAGS += ${XELAB_SYNTH_FLAGS}
XELAB_FLAGS += -pulse_e 0
XELAB_FLAGS += -pulse_int_e 0
XELAB_FLAGS += glbl
XVLOG_FLAGS += -d XIL_TIMING
MVLOG_FLAGS += -define XIL_TIMING
endif

ifeq (${GUI},1)
XSIM_FLAGS += -gui
endif

gelu-synth:
	vivado -nolog -nojournal -notrace -mode batch -source gelu_vivado.tcl

systolic-synth:
	echo "set N1 ${N1}" > args.tcl
	echo "set N2 ${N2}" >> args.tcl
	vivado -nolog -nojournal -notrace -mode batch -source systolic_vivado.tcl

softmax-synth:
	echo 'set SOFTMAX_N ${M1}' > args.tcl
	vivado -nolog -nojournal -notrace -mode batch -source softmax_vivado.tcl

ln-synth:
	vivado -nolog -nojournal -notrace -mode batch -source layer_norm_vivado.tcl

synth-sol-cleanup:
	zsh synth_sol.sh 1

vbuild:
	zsh synth_sol.sh 0 1 ${USE_SYNTH} ${USE_SYNTH_SYSTOLIC} ${USE_SYNTH_SOFTMAX} ${USE_SYNTH_LN} ${USE_SYNTH_GELU}
	verilator ${VFLAGS} \
		--top top dims.sv ${TB}.sv ${UNISIMS} top.cpp \
		--Mdir ${shell pwd}/verilator \
		-o top

xbuild:
	zsh synth_sol.sh 0 1 ${USE_SYNTH} ${USE_SYNTH_SYSTOLIC} ${USE_SYNTH_SOFTMAX} ${USE_SYNTH_LN} ${USE_SYNTH_GELU}
	echo 'set GUI ${GUI}' > args.tcl
	xvlog ${XVLOG_FLAGS} -sv ${SRC}
	xelab ${XELAB_FLAGS} ${TB} -s ${TB}

mbuild:
	echo 'set GUI ${GUI}' > args.tcl
	rm -Rf worl
	vlib work
	vlog -O5 ${MVLOG_FLAGS} -sv ${SRC}

verilator: vbuild
	rm -rf ${TB_DIR}/tb_*.mem
	./verilator/top

xsim: xbuild
	rm -rf ${TB_DIR}/tb_*.mem
	xsim ${TB} ${XSIM_FLAGS} -t xsim.tcl
	python3 ${TEST_SCRIPT} ${TEST_FLAGS}

msim: mbuild
	rm -rf ${TB_DIR}/tb_*.mem
	vsim -c ${TB} 

data:
	mkdir -p ${TB_DIR}
	rm -rf ${TB_DIR}/*.mem
	python3 ${DATA_SCRIPT} ${DATA_FLAGS}

test:
	python3 ${TEST_SCRIPT} ${TEST_FLAGS}

%_tb.sv: ${RUN_DEPS}
	python3 ${TEST_SCRIPT} ${TEST_FLAGS}

args:
	echo 'set M1 ${eM1}' > args.tcl
	echo 'set M2 ${M2}' >> args.tcl
	echo 'set M3 ${M3}' >> args.tcl
	echo 'set N1 ${N1}' >> args.tcl
	echo 'set N2 ${N2}' >> args.tcl
	echo 'set sN1 ${sN1}' >> args.tcl
	echo 'set sN2 ${sN2}' >> args.tcl
	echo 'set BLOCKS ${BLOCKS}' >> args.tcl
	echo 'set DEBUG "${DEBUG}"' >> args.tcl
	echo 'set DEFINES "${DEFINES}"' >> args.tcl
	echo 'set MATRIXSIZE_W ${MATRIXSIZE_W}' >> args.tcl
	echo 'set MEM_DEPTH_A ${MEM_DEPTH_A}' >> args.tcl
	echo 'set MEM_DEPTH_B ${MEM_DEPTH_B}' >> args.tcl
	echo 'set MEM_DEPTH_D ${MEM_DEPTH_D}' >> args.tcl
	echo 'set MEM_DEPTH_Q ${MEM_DEPTH_Q}' >> args.tcl
	echo 'set MEM_DEPTH_K ${MEM_DEPTH_K}' >> args.tcl
	echo 'set MEM_DEPTH_S ${MEM_DEPTH_S}' >> args.tcl
	echo 'set MAT_ADD_MEM_DEPTH ${MAT_ADD_MEM_DEPTH}' >> args.tcl
	echo 'set BLOCKED_D ${BLOCKED_D}' >> args.tcl
	echo 'set MODE "${MODE}"' >> args.tcl
	echo 'set TIMEOUT ${TIMEOUT}' >> args.tcl
#mv args.tcl ${OVERLAY_DIR}/args.tcl

vivado: args
	zsh synth_sol.sh 0 0 ${USE_SYNTH} ${USE_SYNTH_SYSTOLIC} ${USE_SYNTH_SOFTMAX} ${USE_SYNTH_LN} ${USE_SYNTH_GELU}
	vivado ${VIVADO_FLAGS} -source ${VIVADO_SCRIPT}

synth synth-xsim: MODE=synth
impl impl-xsim: MODE=impl
synth impl: vivado
synth-xsim impl-xsim: xsim

bitstream: ${BIT_DEPS}
	zsh synth_sol.sh 0 0 ${USE_SYNTH} ${USE_SYNTH_SYSTOLIC} ${USE_SYNTH_SOFTMAX} ${USE_SYNTH_LN} ${USE_SYNTH_GELU}
	cd ${OVERLAY_DIR} && vivado ${VIVADO_FLAGS} -source build.tcl

board-data:
	rm -rf *.npy
	rm -rf to_board
	python3 board_mem.py heads 0 12
	python3 board_mem.py self_out 0 12
	python3 board_mem.py inter 0 12
	python3 board_mem.py layer_out 0 12
	mkdir to_board
	cp C_req[0-9]*.npy to_board/
	cp I0.npy to_board/I0.npy
	cp O_out[0-9]*.npy to_board/
	scp ./to_board/*.npy xilinx@${PYNQ_IP}:~/
	rm -rf *.npy

board-bits:
	scp ${OVERLAY_DIR}/${BIT_FILE}.bit xilinx@${PYNQ_IP}:~/tutorial.bit
	scp ${OVERLAY_DIR}/${BIT_FILE}.hwh xilinx@${PYNQ_IP}:~/tutorial.hwh

board: ${BOARD_DEPS}
	scp ${BOARD_SCRIPT} xilinx@${PYNQ_IP}:~/
	ssh xilinx@${PYNQ_IP} "source /etc/profile; echo xilinx | sudo -SE python3 ${BOARD_SCRIPT} ${BOARD_FLAFS} 2>&1 | tee board.log;"
	scp xilinx@${PYNQ_IP}:~/board.log ${OVERLAY_DIR}/board-${PYNQ_IP}.log

ibert-data:
	make data TB=attn_head_axi_tb M1=32 M2=768 M3=64 BLOCKS=8
	make data TB=mm_ln_axi_tb M1=32 M2=768 M3=768 BLOCKS=192
	make data TB=mm_gelu_axi_tb M1=32 M2=768 M3=3072 BLOCKS=768
	make data TB=mm_ln_axi_tb M1=32 M2=3072 M3=768 BLOCKS=192

ibert-clean:
	rm -rf tb_head/tb_*.mem
	rm -rf tb_self/tb_*.mem
	rm -rf tb_inter/tb_*.mem
	rm -rf tb_layer/tb_*.mem

ibert_axi_tb.sv: ${RUN_DEPS}
	make test TB=attn_head_axi_tb M1=32 M2=768 M3=64 BLOCKS=8
	make test TB=mm_ln_axi_tb M1=32 M2=768 M3=768 BLOCKS=192
	make test TB=mm_gelu_axi_tb M1=32 M2=768 M3=3072 BLOCKS=768
	make test TB=mm_ln_axi_tb M1=32 M2=3072 M3=768 BLOCKS=192

ibert-board-data:
	scp -r heads/ xilinx@${PYNQ_IP}:~/
	scp -r layer/ xilinx@${PYNQ_IP}:~/

ibert-board-weights:
	python3 preconcat_weights.py
	scp weights.bin weights.json xilinx@${PYNQ_IP}:~/

grade:
	zsh grade.sh ${USE_BOARD} ${PYNQ_IP}
	cat grade.csv

prep-board:
	zsh prep_board.sh

grade-board:
	zsh grade_board.sh ${PYNQ_IP}
	cat grade_board.csv

### UTILS

ping-board:
	ping -c 4 ${PYNQ_IP}

clean: synth-sol-cleanup
	rm -rf *.jou *.pb *.wdb *.str
	rm -rf *.vcd *.fst *.fst.hier args.tcl
	rm -rf ./ibert_overlay/vivado*.jou ./ibert_overlay/vivado*.log
	rm -rf xelab.log xvlog.log xsim*.log vivado*.log
	rm -rf xsim.dir/ .Xil/ work/ lints/ vivado/ __pycache__/ verilator/

reallyclean: clean
	rm -rf *.mem
	rm -rf *.npy
	rm -rf *.vcd
	rm -rf *.fst
	rm -rf *.txt
	rm -rf *.csv
	rm -rf *_synth.sv
	rm -rf *_impl.sv
	rm -rf *.out
	rm -rf *.bin *.json
	rm -rf to_board/

.PHONY: data test %_tb.sv ibert_axi_tb.sv clean reallyclean
