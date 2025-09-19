import numpy as np
from softmax import softmax


def requant(qin: np.int32, bias: np.int32, m: np.int32, e: np.int8) -> np.int8:
    '''
        qin - int32, input
        bias - int32, biasf'{data_folder} - int32, requantization multiplier
        e - int8, requantization shifter
        qout - int8, output
    '''
    qbias = qin + bias                  # int32
    qm = np.int64(qbias) * m            # int64
    qout = np.round(qm * 2.0**(-e))     # int8
    qout = np.int8(qout)
    return qout


def attn_head(I: np.int8, Qw: np.int8, Kw: np.int8, Vw: np.int8,
                     Qb: np.int32, Kb: np.int32, Vb: np.int32,
                     Qm: np.int32, Km: np.int32, Vm: np.int32,
                     Qe: np.int8, Ke: np.int8, Ve: np.int8, 
                     Cm: np.int32, Ce: np.int8) -> np.int8:
    '''
        I - int8, (64,768), input
        Qw, Kw, Vw - int8, (768,64), weights
        Qb, Kb, Vb - int32, (1,64), bias
        Qm, Km, Vm - int32, (1,64), requantization multiplier
        Qe, Ke, Ve - int8, (1,64), requantization shifter
        Cm - int32, (1), requantization multiplier
        Ce - int8, (1), requantization shifter
        qout - int8, output
    '''
    I_Q = np.matmul(I, Qw, dtype=np.int32)
    I_K = np.matmul(I, Kw, dtype=np.int32)
    I_V = np.matmul(I, Vw, dtype=np.int32)

    Q_8 = requant(I_Q, bias=Qb, m=Qm, e=Qe)
    K_8 = requant(I_K, bias=Kb, m=Km, e=Ke)
    V_8 = requant(I_V, bias=Vb, m=Vm, e=Ve)

    S = np.matmul(Q_8, K_8.T, dtype=np.int32)
    P = softmax(qin=S, qb=np.int32(1874), qc=np.int32(1338211),
                qln2=np.int32(-480), qln2_inv=np.int32(-2236963),
                Sreq=np.int32(26291085), fp_bits=30, max_bits=30, out_bits=6)
    C_32 = np.matmul(P, V_8, dtype=np.int32)
    C_8 = requant(C_32, bias=0, m=Cm, e=Ce)
    return C_8


def main():
    print('Starting Attention Evaluation Python...')
    data_folder = 'data32'
    I = np.load(f'{data_folder}/npy/sim_18_self_input_hidden_states_int_model_int.npy')[0]
    Qw = np.load(f'{data_folder}/npy/sim_20_query_weight_integer_model_int.npy')[:,:64]
    Qb = np.load(f'{data_folder}/npy/sim_21_query_bias_integer_model_int.npy')[:64]
    Kw = np.load(f'{data_folder}/npy/sim_22_key_weight_integer_model_int.npy')[:,:64]
    Kb = np.load(f'{data_folder}/npy/sim_23_key_bias_integer_model_int.npy')[:64]
    Vw = np.load(f'{data_folder}/npy/sim_24_value_weight_integer_model_int.npy')[:,:64]
    Vb = np.load(f'{data_folder}/npy/sim_25_value_bias_integer_model_int.npy')[:64]
    Qm = np.load(f'{data_folder}/npy/sim_29_requant_m_model_int.npy')[0][0][:64]
    Qe = np.load(f'{data_folder}/npy/sim_30_requant_e_model_int.npy')[0][0][:64]
    Km = np.load(f'{data_folder}/npy/sim_32_requant_m_model_int.npy')[0][0][:64]
    Ke = np.load(f'{data_folder}/npy/sim_33_requant_e_model_int.npy')[0][0][:64]
    Vm = np.load(f'{data_folder}/npy/sim_35_requant_m_model_int.npy')[0][0][:64]
    Ve = np.load(f'{data_folder}/npy/sim_36_requant_e_model_int.npy')[0][0][:64]
    Cm = np.load(f'{data_folder}/npy/sim_63_requant_m_model_int.npy')[0][0]
    Ce = np.load(f'{data_folder}/npy/sim_64_requant_e_model_int.npy')[0][0]

    true_context = np.load(f'{data_folder}/npy/sim_65_context_layer_int_req_model_int.npy')[0][:,:64]
    context = attn_head(I, Qw, Kw, Vw, Qb, Kb, Vb, Qm, Km, Vm, Qe, Ke, Ve, Cm, Ce)

    if np.all(true_context == context): print("Good")

    print("Finished Attention Evaluation.")


if __name__ == "__main__": 
    main()


