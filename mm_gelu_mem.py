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
    MEM_DIR = str(sys.argv[1])
    LAYER = int(sys.argv[2])
    BLOCKS = int(sys.argv[3])
    REUSE = int(sys.argv[4])
    SLICES = int(sys.argv[5])
    TB_DIR = str(sys.argv[6])
    assert REUSE <= 12
    assert LAYER <= 12
    assert SLICES <= 8

    for r in range(REUSE):
        directory = f"data/layer{LAYER}/{MEM_DIR}"
        mem_files = [file.split('.')[0] for file in os.listdir(directory) if file.endswith('.mem')]
        for mem in mem_files:
            if mem in ['C', 'G_out', 'I', 'A_out',
                       'Y', 'Y_req', 'R_req', 'Z', 'ln_out',
                       'G', 'G_req', 'gelu_out', 'out']:
                # split into SLICESs
                os.system(f"split -n {SLICES} -d -a 1 --additional-suffix=.mem {directory}/{mem}.mem {TB_DIR}/{mem}_{r}_")
            else:
                # need to copy this SLICES times
                for s in range(SLICES):
                    os.system(f"cp {directory}/{mem}.mem {TB_DIR}/{mem}_{r}_{s}.mem")

        if BLOCKS > 1:
            matrix = np.load(f"{directory}/npy/W.npy")
            block_matrix = np.concatenate(np.array_split(matrix, BLOCKS, axis=1))
            for s in range(SLICES):
                write_mem(name=f"{TB_DIR}/W_pp_{str(r*SLICES+s).zfill(3)}", matrix=block_matrix, nbits=32)
        LAYER += 1

    for mem in mem_files:
        for r in range(REUSE):
            for s in range(SLICES):
                os.system(f"mv {TB_DIR}/{mem}_{r}_{s}.mem {TB_DIR}/{mem}_{str(r*SLICES+s).zfill(3)}.mem")
        os.system(f"cat {TB_DIR}/{mem}_[0-9]*.mem > {TB_DIR}/{mem}.mem")

    if BLOCKS > 1:
        os.system(f"cat {TB_DIR}/W_pp_[0-9]*.mem > {TB_DIR}/W_pp.mem")


if __name__ == "__main__":
    main()
