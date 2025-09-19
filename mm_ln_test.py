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


def load_mem(mem_file, dim1, dim2):
    mat_data = np.zeros((int(dim1),int(dim2)), dtype=np.int32)
    if os.path.exists(mem_file):
        mem_data = open(mem_file)
        for row in range(0,dim1):
            for col in range(0,dim2):
                line = mem_data.readline().strip()
                mat_data[row][col] = hex2dec(line)
        return mat_data
    else:
        raise FileNotFoundError(f"The file {mem_file} does not exist.")


def test(mem_dir, mem_Y, mem_Y_req, mem_R_req, mem_Z, mem_ln_out, mem_out, dim1, dim2, verbose=False):
    Y = load_mem(f"{mem_dir}/tb_{mem_Y}.mem", dim1, dim2)
    Y_req = load_mem(f"{mem_dir}/tb_{mem_Y_req}.mem", dim1, dim2)
    R_req = load_mem(f"{mem_dir}/tb_{mem_R_req}.mem", dim1, dim2)
    Z = load_mem(f"{mem_dir}/tb_{mem_Z}.mem", dim1, dim2)
    ln_out = load_mem(f"{mem_dir}/tb_{mem_ln_out}.mem", dim1, dim2)
    out = load_mem(f"{mem_dir}/tb_{mem_out}.mem", dim1, dim2)

    true_Y = load_mem(f"{mem_dir}/{mem_Y}.mem", dim1, dim2)
    true_Y_req = load_mem(f"{mem_dir}/{mem_Y_req}.mem", dim1, dim2)
    true_R_req = load_mem(f"{mem_dir}/{mem_R_req}.mem", dim1, dim2)
    true_Z = load_mem(f"{mem_dir}/{mem_Z}.mem", dim1, dim2)
    true_ln_out = load_mem(f"{mem_dir}/{mem_ln_out}.mem", dim1, dim2)
    true_out = load_mem(f"{mem_dir}/{mem_out}.mem", dim1, dim2)

    if np.array_equal(Y,true_Y):
        print("-- Y=X*W Passed! :) -- ")
    else:
        print("-- Y=X*W Failed! :( -- ")
    if np.array_equal(Y_req,true_Y_req):
        print("-- Y Requantization Passed! :) -- ")
    else:
        print("-- Y Requantization Failed! :( -- ")
    if np.array_equal(R_req,true_R_req):
        print("-- R Requantization Passed! :) -- ")
    else:
        print("-- R Requantization Failed! :( -- ")
    if np.array_equal(Z,true_Z):
        print("-- Z = Y_req + R_req Passed! :) -- ")
    else:
        print("-- Z = Y_req + R_req Failed! :( -- ")
    if np.array_equal(ln_out,true_ln_out):
        print("-- layer_norm Passed! :) -- ")
    else:
        print("-- layer_norm Failed! :( -- ")
    if np.array_equal(out,true_out):
        print("-- Good Job! mm_ln Output Requantization, Correct! :) -- ")
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
    TB_DIR = str(sys.argv[5])

    mem_files = {'mem_Y': 'Y',
                 'mem_Y_req': 'Y_req',
                 'mem_R_req': 'R_req',
                 'mem_Z': 'Z',
                 'mem_ln_out': 'ln_out',
                 'mem_out': 'out'}

    for mem in mem_files.values():
        os.system(f"split -l {int(M1*M3)} -d -a 3 --additional-suffix=.mem {TB_DIR}/tb_{mem}.mem {TB_DIR}/tb_{mem}_")

    for r in range(REUSE):
        print(f"\nLayer: {r+1}")
        args = {k: f"{v}_{str(r).zfill(3)}" for k, v in mem_files.items()}
        test(mem_dir=TB_DIR, **args, dim1=M1, dim2=M3)


if __name__ == "__main__":
    main()
