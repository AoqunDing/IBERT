import os
import sys
import time
import json
import signal
import numpy as np
from collections import OrderedDict

from pynq import Overlay
from pynq import MMIO
from pynq import PL

import pynq
if (pynq.__version__ == '2.5'):
    from pynq import Xlnk
    xlnk = Xlnk()
    allocatem = xlnk.cma_array
elif (pynq.__version__ == '3.0.1'):
    import cProfile
    import pstats
    from pstats import SortKey
    from pynq import allocate
    allocatem = allocate
else:
    raise Exception(f"Error: Not supported pynq version: {pynq.__version__}")


def handler(signum, frame):
    print("Error: board.py timed out waiting for the board to respond. Likely DMA error or board busy.")
    raise Exception("Timeout")


ascii_thank = r'''Thank Mr. Goose'''
ascii_hisssss = r'''HISSSSS!!'''


def load_weights(model_path, metadata_path):
    # Load metadata from JSON
    with open(metadata_path, 'r') as f:
        loaded_metadata = json.load(f)
    # Load binary data
    loaded_sd = OrderedDict()
    with open(model_path, 'rb') as f:
        for key, shape in loaded_metadata.items():
            size = int(np.prod(shape))
            data = np.frombuffer(f.read(size * 4), dtype=np.int32).reshape(shape)
            loaded_sd[key] = data
    return loaded_sd


def compare(out_buffer, true_out):
    print("##########")
    if np.array_equal(out_buffer, true_out):
        print(ascii_thank)
    else:
        print(ascii_hisssss)
        print("True Answer is:")
        print(true_out)
        print("Your Answer is:")
        print(out_buffer)
        print("Diff:")
        print(true_out - out_buffer)
        print("Non-equal elements:")
        print(f"true_out: {true_out[true_out != out_buffer]}")
        print(f"out_buffer: {out_buffer[true_out != out_buffer]}")
    print("##########")


def run():
    PL.reset()
    start_main_time = time.time()
    print("\n--\nStarting Board Test...")
    import os
    os.system("rm -rf /home/xilinx/pynq/pl_server/_current_metadata.pkl")
    os.system("rm -rf /home/xilinx/pynq/pl_server/global_pl_state.json")

    print(f"PYNQ version on the board: {pynq.__version__}")
    signal.signal(signal.SIGALRM, handler)

    N1 = int(sys.argv[1])
    N2 = int(sys.argv[2])
    NUM_LAYERS = 12
    NUM_HEADS = 12
    IP_BASE_ADDRESS = 0x43C10000
    ADDRESS_RANGE = 0x1000
    ADDRESS_OFFSET = 0x10

    start_setup_time = time.time()
    overlay = Overlay('./tutorial.bit')
    dma = overlay.mm_eval.axi_dma
    print("Loaded Bitstream.")
    mmio = MMIO(IP_BASE_ADDRESS, ADDRESS_RANGE)
    end_setup_time = time.time()
    print(f"Bitstream Setup Time spent: {1000*(end_setup_time - start_setup_time)}ms")

    start_weights_time = time.time()
    loaded_weights = load_weights("weights.bin", "weights.json")
    end_weights_time = time.time()
    print(f"Load Weights Time spent: {1000*(end_weights_time - start_weights_time)}ms")

    start_buffer_create_time = time.time()
    M1, M2, M3, BLOCKS = 32, 768, 64, 8
    DMA_IN_BUFFER_SIZE_HEAD_I = M1*M2
    DMA_IN_BUFFER_SIZE_HEAD = 3*M2*M3+3*3*M3+2
    DMA_OUT_BUFFER_SIZE_HEAD = NUM_HEADS*M1*M3
    in_buffer_head = OrderedDict()
    in_buffer_head['I'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_HEAD_I,), dtype=np.int32)
    for h in range(NUM_HEADS):
        in_buffer_head[f'head{h}'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_HEAD,), dtype=np.int32)
    out_buffer_head = allocatem(shape=(DMA_OUT_BUFFER_SIZE_HEAD,), dtype=np.int32)

    SLICES = 1
    M1, M2, M3, BLOCKS = 32, 768, 768, 192
    M1 = int(M1/SLICES)
    DMA_IN_BUFFER_SIZE_SELF_X = M1*M2
    DMA_IN_BUFFER_SIZE_SELF_0 = M2*M3+2
    DMA_IN_BUFFER_SIZE_SELF_R = M1*M3
    DMA_IN_BUFFER_SIZE_SELF_1 = 6*M3
    in_buffer_self = OrderedDict()
    in_buffer_self['0'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_SELF_0,), dtype=np.int32)
    in_buffer_self['1'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_SELF_1,), dtype=np.int32)

    M1, M2, M3, BLOCKS = 32, 768, 3072, 768
    M1 = int(M1/SLICES)
    DMA_IN_BUFFER_SIZE_INTER = M2*M3+M3+2
    in_buffer_inter = OrderedDict()
    in_buffer_inter['0'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_INTER//2,), dtype=np.int32)
    in_buffer_inter['1'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_INTER//2,), dtype=np.int32)

    M1, M2, M3, BLOCKS = 32, 3072, 768, 192
    M1 = int(M1/SLICES)
    DMA_IN_BUFFER_SIZE_LAYER_0 = M2*M3+2
    DMA_IN_BUFFER_SIZE_LAYER_1 = 6*M3
    DMA_OUT_BUFFER_SIZE_LAYER = SLICES*M1*M3
    in_buffer_layer = OrderedDict()
    in_buffer_layer['0'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_LAYER_0//2,), dtype=np.int32)
    in_buffer_layer['1'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_LAYER_0//2,), dtype=np.int32)
    in_buffer_layer['2'] = allocatem(shape=(DMA_IN_BUFFER_SIZE_LAYER_1,), dtype=np.int32)

    out_buffer_layer = allocatem(shape=(DMA_OUT_BUFFER_SIZE_LAYER,), dtype=np.int32)

    end_buffer_create_time = time.time()
    print(f"Buffer Create Time spent: {1000*(end_buffer_create_time - start_buffer_create_time)}ms")

    start_all_layers_time = time.time()
    I = np.load(f"I0.npy").flatten()
    np.copyto(in_buffer_head['I'], I)
    for r in range(NUM_LAYERS):
        print(f"--\nLayer: {r}")
        start_layer_time = time.time()
        start_np_load_time = time.time()
        C_req = np.load(f"C_req{r}.npy").squeeze()
        C_req = np.array_split(C_req,NUM_HEADS,axis=1)
        layer_true_out = np.load(f"O_out{r}.npy").squeeze()
        end_np_load_time = time.time()
        print(f"np load Time spent: {1000*(end_np_load_time - start_np_load_time)}ms")

        start_all_heads_time = time.time()
        for h in range(NUM_HEADS):
            C_req[h] = C_req[h].flatten()
            np.copyto(in_buffer_head[f'head{h}'], loaded_weights[f'layer{r}_head{h}'])

        signal.alarm(5)
        print("Data transfer to the board over AXI Stream interface...")
        start_time = time.time()
        try:
            dma.recvchannel.transfer(out_buffer_head)
            if r == 0:
                dma.sendchannel.transfer(in_buffer_head['I'])
                dma.sendchannel.wait()
                print(f"One Headms")
            for h in range(NUM_HEADS):
                start_one_head_time = time.time()
                dma.sendchannel.transfer(in_buffer_head[f'head{h}'])
                dma.sendchannel.wait()
                end_one_head_time = time.time()
                print(f"One Head-{h} Time spent: {1000*(end_one_head_time - start_one_head_time)}ms")
            print("Sent inputs.")
            dma.recvchannel.wait()
            end_time = time.time()
            print("Received output.")
            print(f"Heads Com Time spent: {1000*(end_time - start_time)}ms")
        except Exception as exc:
            print("Error: timed out while waiting for data transfer to finish.")
            print(exc)
            exit(1)
        signal.alarm(0)

        compare(out_buffer=out_buffer_head, true_out=np.concatenate(C_req))
        end_all_heads_time = time.time()
        print(f"All Heads Time spent: {1000*(end_all_heads_time - start_all_heads_time)}ms")

        start_rest_buffer_time = time.time()
        np.copyto(in_buffer_self['0'], loaded_weights[f'layer{r}_self_out0'])
        np.copyto(in_buffer_self['1'], loaded_weights[f'layer{r}_self_out1'])
        np.copyto(in_buffer_inter['0'], loaded_weights[f'layer{r}_inter'][:DMA_IN_BUFFER_SIZE_INTER//2])
        np.copyto(in_buffer_inter['1'], loaded_weights[f'layer{r}_inter'][DMA_IN_BUFFER_SIZE_INTER//2:])
        np.copyto(in_buffer_layer['0'], loaded_weights[f'layer{r}_layer_out0'][:DMA_IN_BUFFER_SIZE_LAYER_0//2])
        np.copyto(in_buffer_layer['1'], loaded_weights[f'layer{r}_layer_out0'][DMA_IN_BUFFER_SIZE_LAYER_0//2:])
        np.copyto(in_buffer_layer['2'], loaded_weights[f'layer{r}_layer_out1'])

        end_rest_buffer_time = time.time()
        print(f"Rest Buffer Time spent: {1000*(end_rest_buffer_time - start_rest_buffer_time)}ms")

        signal.alarm(5)
        print("Data transfer to the board over AXI Stream interface...")
        start_time = time.time()
        try:
            dma.recvchannel.transfer(out_buffer_layer)
            for s in range(SLICES):
                # self
                start_self_slice_time = time.time()
                dma.sendchannel.transfer(in_buffer_self['0'])
                dma.sendchannel.wait()
                dma.sendchannel.transfer(in_buffer_self['1'])
                dma.sendchannel.wait()
                end_self_slice_time = time.time()
                # inter
                start_inter_slice_time = time.time()
                dma.sendchannel.transfer(in_buffer_inter['0'])
                dma.sendchannel.wait()
                dma.sendchannel.transfer(in_buffer_inter['1'])
                dma.sendchannel.wait()
                end_inter_slice_time = time.time()
                # layer
                start_layer_slice_time = time.time()
                dma.sendchannel.transfer(in_buffer_layer['0'])
                dma.sendchannel.wait()
                dma.sendchannel.transfer(in_buffer_layer['1'])
                dma.sendchannel.wait()
                dma.sendchannel.transfer(in_buffer_layer['2'])
                dma.sendchannel.wait()
                end_layer_slice_time = time.time()
                print(f"Self Slice-{s} Time spent: {1000*(end_self_slice_time - start_self_slice_time)}ms")
                print(f"Inter Slice-{s} Time spent: {1000*(end_inter_slice_time - start_inter_slice_time)}ms")
                print(f"Layer Slice-{s} Time spent: {1000*(end_layer_slice_time - start_layer_slice_time)}ms")
            print("Sent inputs.")
            dma.recvchannel.wait()
            end_time = time.time()
            print("Received output.")
            print(f"Rest Com Time spent: {1000*(end_time - start_time)}ms")
        except Exception as exc:
            print("Error: timed out while waiting for data transfer to finish.")
            print(exc)
            exit(1)
        signal.alarm(0)

        compare(out_buffer=out_buffer_layer, true_out=layer_true_out.flatten())
        end_layer_time = time.time()
        np.save(f"O_out{r}.npy",out_buffer_layer.reshape((32,768)));
        print(f"One Layer Time spent: {(end_layer_time - start_layer_time)}s")
    end_all_layers_time = time.time()
    print(f"All Layer Time spent: {(end_all_layers_time - start_all_layers_time)}s")

    end_main_time = time.time()
    print(f"Main Time spent: {(end_main_time - start_main_time)}s")


def main():
    import gc
    gc.collect()
    debug = False
    if (debug and pynq.__version__ == '3.0.1'):
        profile = cProfile.Profile()
        profile.run('run()')
        stats = pstats.Stats(profile).sort_stats(SortKey.CUMULATIVE)
        stats.print_stats()
    else:
        run()


if __name__ == "__main__":
    main()

