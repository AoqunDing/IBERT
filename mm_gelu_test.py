import os
import sys
import numpy as np

ascii_thank = r'''
                                   ___
                               ,-""   `.
       Thank Mr. Goose       ,'  _   ' )`-._
                            /  ,' `-._<.===-'
                           /  /
                          /  ;
              _          /   ;
 (`._    _.-"" ""--..__,'    |
 <_  `-""                     \
  <`-                          :
   (__   <__.                  ;
     `-.   '-.__.      _.'    /
        \      `-.__,-'    _,'
         `._    ,    /__,-'
            ""._\__,'< <____
                 | |  `----.`.
                 | |        \ `.
                 ; |___      \-``
                 \   --<
                  `.`.<
                    `-'
                    
'''


ascii_hisssss = r'''
                                                        _...--.
                                        _____......----'     .'
                                  _..-''                   .'
                                .'                       ./
                        _.--._.'                       .' |
                     .-'                           .-.'  /
  HISSSSS!!        .'   _.-.                     .  \   '
                 .'  .'   .'    _    .-.        / `./  :
               .'  .'   .'  .--' `.  |  \  |`. |     .'
            _.'  .'   .' `.'       `-'   \ / |.'   .'
         _.'  .-'   .'     `-.            `      .'
       .'   .'    .'          `-.._ _ _ _ .-.    :
      /    /o _.-'               .--'   .'   \   |
    .'-.__..-'                  /..    .`    / .'
  .'   . '                       /.'/.'     /  |
 `---'                                   _.'   '
                                       /.'    .'
                                        /.'/.'
                                        
'''


def hex2dec(hex_num):
    if 'x' in hex_num:
        return 0
    dec_num = int(hex_num, 16)
    nbits = len(hex_num) * 4
    if dec_num & (1 << (nbits - 1)):
        dec_num -= 1 << nbits
    return dec_num


def load_mem(mem_file, dim1, dim2, blocks=1):
    mat_data = np.zeros((int(dim1),int(dim2)), dtype=np.int32)
    if os.path.exists(mem_file):
        mem_data = open(mem_file)
        for row in range(0,dim1):
            for col in range(0,dim2):
                line = mem_data.readline().strip()
                mat_data[row][col] = hex2dec(line)
        if blocks > 1: mat_data = np.concatenate(mat_data.reshape((blocks, dim1, dim2//blocks)),axis=1)
        return mat_data
    else:
        raise FileNotFoundError(f"The file {mem_file} does not exist.")


def test(mem_dir, mem_G, mem_G_req, mem_gelu_out, mem_out, dim1, dim2, BLOCKS_D=1, verbose=False):
    G = load_mem(f"{mem_dir}/tb_{mem_G}.mem", dim1, dim2, blocks=BLOCKS_D)
    G_req = load_mem(f"{mem_dir}/tb_{mem_G_req}.mem", dim1, dim2, blocks=BLOCKS_D)
    gelu_out = load_mem(f"{mem_dir}/tb_{mem_gelu_out}.mem", dim1, dim2, blocks=BLOCKS_D)
    out = load_mem(f"{mem_dir}/tb_{mem_out}.mem", dim1, dim2, blocks=BLOCKS_D)

    true_G = load_mem(f"{mem_dir}/{mem_G}.mem", dim1, dim2)
    true_G_req = load_mem(f"{mem_dir}/{mem_G_req}.mem", dim1, dim2)
    true_gelu_out = load_mem(f"{mem_dir}/{mem_gelu_out}.mem", dim1, dim2)
    true_out = load_mem(f"{mem_dir}/{mem_out}.mem", dim1, dim2)

    if np.array_equal(G,true_G):
        print("-- G=A*W Passed! :) -- ")
    else:
        print("-- G=A*W Failed! :( -- ")
    if np.array_equal(G_req,true_G_req):
        print("-- G Requantization Passed! :) -- ")
    else:
        print("-- G Requantization Failed! :( -- ")
    if np.array_equal(gelu_out,true_gelu_out):
        print("-- gelu Passed! :) -- ")
    else:
        print("-- gelu Failed! :( -- ")
    if np.array_equal(out,true_out):
        print("-- Good Job! mm_gelu Output Requantization, Correct! :) -- ")
        print(ascii_thank)
    else:
        print("-- Output Requantization Failed! :( -- ")
        print(ascii_hisssss)
    print("##########")


def main():
    M1 = int(sys.argv[1])
    M2 = int(sys.argv[2])
    M3 = int(sys.argv[3])
    REUSE = int(sys.argv[4])
    BLOCKS_D = int(sys.argv[5])
    TB_DIR = str(sys.argv[6])

    mem_files = {'mem_G': 'G',
                 'mem_G_req': 'G_req',
                 'mem_gelu_out': 'gelu_out',
                 'mem_out': 'out',}

    for mem in mem_files.values():
        os.system(f"split -l {int(M1*M3)} -d -a 3 --additional-suffix=.mem {TB_DIR}/tb_{mem}.mem {TB_DIR}/tb_{mem}_")

    for r in range(REUSE):
        print(f"\nLayer: {r+1}")
        args = {k: f"{v}_{str(r).zfill(3)}" for k, v in mem_files.items()}
        test(mem_dir=TB_DIR, **args, dim1=M1, dim2=M3, BLOCKS_D=BLOCKS_D)


if __name__ == "__main__":
    main()
