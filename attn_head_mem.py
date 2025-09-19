import os
import sys
import numpy as np


def dec2hex(dec_num, nbits):
    bit_range = (1 << nbits) - 1
    hlen = int(np.ceil(nbits/4))
    hex_num = format(dec_num & bit_range, f'0{hlen}x')
    return hex_num


def write_mem(name, matrix, nbits=8):
    hex_lines = "\n".join(dec2hex(num, nbits=nbits) for num in matrix.ravel())
    with open(f"{name}.mem", "w") as mem:
        mem.write(hex_lines + "\n")

def main():
    BLOCKS = int(sys.argv[1])
    REUSE = int(sys.argv[2])
    KEEP_A = int(sys.argv[3])
    HEADS = int(sys.argv[4])
    TB_DIR = str(sys.argv[5])
    NUM_HEADS = 12
    assert REUSE <= 12
    assert HEADS <= NUM_HEADS
    assert KEEP_A <= HEADS

    directory = f"data/layer0/heads/head0"
    mem_files = [file.split('.')[0] for file in os.listdir(directory) if file.endswith('.mem')]
    mem_files.remove('I')
    for r in range(REUSE):
        for h in range(HEADS):
            directory = f"data/layer{r}/heads/head{h}"
            for mem in mem_files:
                os.system(f"cp {directory}/{mem}.mem {TB_DIR}/{mem}_{str(r*HEADS+h).zfill(3)}.mem")
        for k in range(HEADS//KEEP_A):
            os.system(f"cp data/layer{r}/heads/head0/I.mem {TB_DIR}/I_{str(r*HEADS//KEEP_A+k).zfill(3)}.mem")

    for r in range(REUSE):
        directory = f"data/layer{r}/heads/npy"
        if BLOCKS > 1:
            for mat in ['W_K', 'W_V', 'W_Q']:
                W = np.load(f"{directory}/{mat}.npy")
                W = np.array_split(W, NUM_HEADS, axis=1)
                for h in range(HEADS):
                    matrix = W[h]
                    block_matrix = np.concatenate(np.array_split(matrix, BLOCKS, axis=1))
                    write_mem(name=f"{TB_DIR}/{mat}_pp_{str(r*HEADS+h).zfill(3)}", matrix=block_matrix, nbits=32)

    for mem in mem_files + ['I']:
        if mem in ['W_Q', 'W_K', 'W_V'] and BLOCKS > 1:
            os.system(f"cat {TB_DIR}/{mem}_pp_[0-9]*.mem > {TB_DIR}/{mem}_pp.mem")
        else:
            os.system(f"cat {TB_DIR}/{mem}_[0-9]*.mem > {TB_DIR}/{mem}.mem")


if __name__ == "__main__":
    main()
