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

def test(mem_dir, mem_Q, mem_K, mem_V, 
         mem_Q_req, mem_K_req, mem_V_req,
         mem_S, mem_P, mem_C, mem_C_req,
         dim1, dim2, verbose=False):
    
    Q = load_mem(f"{mem_dir}/tb_{mem_Q}.mem", dim1, dim2)
    K = load_mem(f"{mem_dir}/tb_{mem_K}.mem", dim1, dim2)
    V = load_mem(f"{mem_dir}/tb_{mem_V}.mem", dim1, dim2)
    Q_req = load_mem(f"{mem_dir}/tb_{mem_Q_req}.mem", dim1, dim2)
    K_req = load_mem(f"{mem_dir}/tb_{mem_K_req}.mem", dim1, dim2)
    V_req = load_mem(f"{mem_dir}/tb_{mem_V_req}.mem", dim1, dim2)
    S = load_mem(f"{mem_dir}/tb_{mem_S}.mem", dim1, dim1)
    softmax_out = load_mem(f"{mem_dir}/tb_{mem_P}.mem", dim1, dim1)
    C = load_mem(f"{mem_dir}/tb_{mem_C}.mem", dim1, dim2)
    C_req = load_mem(f"{mem_dir}/tb_{mem_C_req}.mem", dim1, dim2)

    true_Q = load_mem(f"{mem_dir}/{mem_Q}.mem", dim1, dim2)
    true_K = load_mem(f"{mem_dir}/{mem_K}.mem", dim1, dim2)
    true_V = load_mem(f"{mem_dir}/{mem_V}.mem", dim1, dim2)
    true_Q_req = load_mem(f"{mem_dir}/{mem_Q_req}.mem", dim1, dim2)
    true_K_req = load_mem(f"{mem_dir}/{mem_K_req}.mem", dim1, dim2)
    true_V_req = load_mem(f"{mem_dir}/{mem_V_req}.mem", dim1, dim2)
    true_S = load_mem(f"{mem_dir}/{mem_S}.mem", dim1, dim1)
    true_softmax_out = load_mem(f"{mem_dir}/{mem_P}.mem", dim1, dim1)
    true_C = load_mem(f"{mem_dir}/{mem_C}.mem", dim1, dim2)
    true_C_req = load_mem(f"{mem_dir}/{mem_C_req}.mem", dim1, dim2)

    if np.array_equal(Q,true_Q):
        print("-- Q=I*W_Q Passed! :) -- ")
    else:
        print("-- Q=I*W_Q Failed! :( -- ")
    if np.array_equal(Q_req,true_Q_req):
        print("-- Q Requantization Passed! :) -- ")
    else:
        print("-- Q Requantization Failed! :( -- ")
    if np.array_equal(K,true_K):
        print("-- K=I*W_K Passed! :) -- ")
    else:
        print("-- K=I*W_K Failed! :( -- ")
    if np.array_equal(K_req,true_K_req):
        print("-- K Requantization Passed! :) -- ")
    else:
        print("-- K Requantization Failed! :( -- ")
    if np.array_equal(V,true_V):
        print("-- V=I*W_V Passed! :) -- ")
    else:
        print("-- V=I*W_V Failed! :( -- ")
    if np.array_equal(V_req,true_V_req):
        print("-- V Requantization Passed! :) -- ")
    else:
        print("-- V Requantization Failed! :( -- ")
    if np.array_equal(S,true_S):
        print("-- S=Q*K Passed! :) -- ")
    else:
        print("-- S=Q*K Failed! :( -- ")
    if np.array_equal(softmax_out,true_softmax_out):
        print("-- P=softmax(S) Passed! :) -- ")
    else:
        print("-- P=softmax(S) Failed! :( -- ")
    if np.array_equal(C,true_C):
        print("-- C=P*V Passed! :) -- ")
    else:
        print("-- C=P*V Failed! :( -- ")
    if np.array_equal(C_req,true_C_req):
        print("-- Good Job! Attention Head Output, C Requantization, Correct! :) -- ")
        print(ascii_thank)
    else:
        print("-- C Requantization Failed! :( -- ")
        print(ascii_hisssss)
    print("##########")


def main():
    M1 = int(sys.argv[1])
    M2 = int(sys.argv[2])
    M3 = int(sys.argv[3])
    REUSE = int(sys.argv[4])
    HEADS = int(sys.argv[5])
    TB_DIR = str(sys.argv[6])

    mem_files = {'mem_Q': ('Q', M1, M3),
                 'mem_K': ('K', M1, M3),
                 'mem_V': ('V', M1, M3),
                 'mem_Q_req': ('Q_req', M1, M3),
                 'mem_K_req': ('K_req', M1, M3),
                 'mem_V_req': ('V_req', M1, M3),
                 'mem_S': ('S', M1, M1),
                 'mem_P': ('P', M1, M1),
                 'mem_C': ('C', M1, M3),
                 'mem_C_req': ('C_req', M1, M3)}

    for mem, dim1, dim2 in mem_files.values():
        os.system(f"split -l {int(dim1*dim2)} -d -a 3 --additional-suffix=.mem {TB_DIR}/tb_{mem}.mem {TB_DIR}/tb_{mem}_")

    for r in range(REUSE*HEADS):
        print(f"\nHead: {r+1}")
        args = {k: f"{v[0]}_{str(r).zfill(3)}" for k, v in mem_files.items()}
        test(mem_dir=TB_DIR, **args, dim1=M1, dim2=M3)


if __name__ == "__main__":
    main()
