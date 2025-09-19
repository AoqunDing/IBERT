import os
import sys


def main():
    MEM_DIR = str(sys.argv[1])
    LAYER = int(sys.argv[2])
    REUSE = int(sys.argv[3])

    for r in range(REUSE):
        directory = f"data/layer{LAYER}/{MEM_DIR}/npy"
        for file in os.listdir(directory):
            os.system(f"cp {directory}/{file} {file.split('.')[0]}{r}.npy")
        LAYER += 1


if __name__ == "__main__":
    main()
