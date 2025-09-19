import os
import json
import numpy as np
from collections import OrderedDict


def load_weights(state_dict, n_layers=12, n_heads=12, head_size=64, **config):
        weights = OrderedDict()
        weights['embed'] = OrderedDict(
            word_emb = state_dict['ibert.embeddings.word_embeddings.weight_integer'],
            pos_emb = state_dict['ibert.embeddings.position_embeddings.weight_integer'],
            m_1 = state_dict['ibert.embeddings.embeddings_act2.m'],
            e_1 = state_dict['ibert.embeddings.embeddings_act2.e'],
            m_2 = state_dict['ibert.embeddings.embeddings_act1.m'],
            e_2 = state_dict['ibert.embeddings.embeddings_act1.e'],
            r_m = state_dict['ibert.embeddings.embeddings_act1.m1'],
            r_e = state_dict['ibert.embeddings.embeddings_act1.e1'],
            m_3 = state_dict['ibert.embeddings.output_activation.m'],
            e_3 = state_dict['ibert.embeddings.output_activation.e'],
            ln_bias = state_dict['ibert.embeddings.LayerNorm.bias_integer'],
        )

        for layer_id in range(n_layers):
            for head_id in range(n_heads):
                head_start = head_id * head_size
                head_end = (head_id + 1) * head_size
                weights[f'layer{layer_id}_head{head_id}'] = OrderedDict(
                    W_Q = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.query.weight_integer'].T[:,head_start:head_end],
                    W_K = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.key.weight_integer'].T[:,head_start:head_end],
                    W_V = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.value.weight_integer'].T[:,head_start:head_end],
                    bias_Q = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.query.bias_integer'][head_start:head_end],
                    bias_K = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.key.bias_integer'][head_start:head_end],
                    bias_V = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.value.bias_integer'][head_start:head_end],
                    Q_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.query_activation.m'][head_start:head_end],
                    K_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.key_activation.m'][head_start:head_end],
                    V_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.value_activation.m'][head_start:head_end],
                    Q_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.query_activation.e'][head_start:head_end],
                    K_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.key_activation.e'][head_start:head_end],
                    V_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.value_activation.e'][head_start:head_end],
                    C_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.output_activation.m'],
                    C_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.output_activation.e'],
                    qb = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.softmax.softmax_qb'],
                    qc = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.softmax.softmax_qc'],
                    qln2 = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.softmax.softmax_qln2'],
                    qln2_inv = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.softmax.softmax_qln2_inv'],
                    Sreq = state_dict[f'ibert.encoder.layer.{layer_id}.attention.self.softmax.softmax_Sreq'],
                )

            weights[f'layer{layer_id}_self_out'] = OrderedDict(
                W = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.dense.weight_integer'].T,
                W_bias = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.dense.bias_integer'],
                W_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.ln_input_act.m'],
                W_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.ln_input_act.e'],
                R_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.ln_input_act.m1'],
                R_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.ln_input_act.e1'],
                ln_bias = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.LayerNorm.bias_integer'],
                out_m = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.output_activation.m'],
                out_e = state_dict[f'ibert.encoder.layer.{layer_id}.attention.output.output_activation.e'],
            )

            weights[f'layer{layer_id}_inter'] = OrderedDict(
                W = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.dense.weight_integer'].T,
                W_bias = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.dense.bias_integer'],
                out_m = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.output_activation.m'],
                out_e = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.output_activation.e'],
                gelu_qb = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.intermediate_act_fn.gelu_qb'],
                gelu_qc = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.intermediate_act_fn.gelu_qc'],
                gelu_q1 = state_dict[f'ibert.encoder.layer.{layer_id}.intermediate.intermediate_act_fn.gelu_q1'],
            )

            weights[f'layer{layer_id}_layer_out'] = OrderedDict(
                W = state_dict[f'ibert.encoder.layer.{layer_id}.output.dense.weight_integer'].T,
                W_bias = state_dict[f'ibert.encoder.layer.{layer_id}.output.dense.bias_integer'],
                W_m = state_dict[f'ibert.encoder.layer.{layer_id}.output.ln_input_act.m'],
                W_e = state_dict[f'ibert.encoder.layer.{layer_id}.output.ln_input_act.e'],
                R_m = state_dict[f'ibert.encoder.layer.{layer_id}.output.ln_input_act.m1'],
                R_e = state_dict[f'ibert.encoder.layer.{layer_id}.output.ln_input_act.e1'],
                ln_bias = state_dict[f'ibert.encoder.layer.{layer_id}.output.LayerNorm.bias_integer'],
                out_m = state_dict[f'ibert.encoder.layer.{layer_id}.output.output_activation.m'],
                out_e = state_dict[f'ibert.encoder.layer.{layer_id}.output.output_activation.e'],
            )

        weights['lm_head'] = OrderedDict(
            W_1 = state_dict['lm_head.dense.weight'].T,
            bias_1 = state_dict['lm_head.dense.bias'],
            W_2 = state_dict['lm_head.decoder.weight'].T,
            bias_2 = state_dict['lm_head.decoder.bias'],
            ln_weight = state_dict['lm_head.layer_norm.weight'],
            ln_bias = state_dict['lm_head.layer_norm.bias'],
        )

        return weights


def load_model(model_path, metadata_path):
    # Load metadata from JSON
    with open(metadata_path, 'r') as f:
        loaded_metadata = json.load(f)

    # Load binary data
    loaded_sd = OrderedDict()
    with open(model_path, 'rb') as f:
        for key, value in loaded_metadata.items():
            shape, dtype = value
            size = int(np.prod(shape))
            if dtype == 'int8':
                data = np.frombuffer(f.read(size * 1), dtype=np.int8).reshape(shape)
            elif dtype == 'int32':
                data = np.frombuffer(f.read(size * 4), dtype=np.int32).reshape(shape)
            elif dtype == 'float32':
                data = np.frombuffer(f.read(size * 4), dtype=np.float32).reshape(shape)
            loaded_sd[key] = data
    return loaded_sd


def save_mem(file_path, mat, nbits=32, write='w'):
    with open(file_path, write) as mem_file:
        if len(mat.shape) == 1:
            for row in range(mat.shape[0]):
                if nbits == 32: line = format(int(mat[row]) & 0xFFFFFFFF, '08x')
                elif nbits == 8: line = format(int(mat[row]) & 0xFF, '02x')
                mem_file.write(line + '\n')
        elif len(mat.shape) == 2:
            for row in range(mat.shape[0]):
                for col in range(mat.shape[1]):
                    if nbits == 32: line = format(int(mat[row][col]) & 0xFFFFFFFF, '08x')
                    elif nbits == 8: line = format(int(mat[row][col]) & 0xFF, '02x')
                    mem_file.write(line + '\n')
        else:
            if nbits == 32: line = format(int(mat) & 0xFFFFFFFF, '08x')
            elif nbits == 8: line = format(int(mat) & 0xFF, '02x')
            mem_file.write(line + '\n')


def nrmse(targets, predictions):
    return np.sqrt(((predictions - targets) ** 2).mean()) / (targets.max() - targets.min())


def compare_npy_arrays(arr1, arr2, atol=0.00, rtol=0.00):
    same = False
    log = "empty"
    if arr1.shape != arr2.shape:
        same = False
        log = f"Shapes are not SAME: {arr1.shape, arr2.shape}"
    else:
        not_equals = ~np.isclose(arr1, arr2, atol=atol, rtol=rtol, equal_nan=False)
        same = (not_equals.sum() == 0)
        p = round(100 * not_equals.sum() / (not_equals.sum() + (~not_equals).sum()), 2)
        log = f"{not_equals.sum()} not-equal elements ({p}%): {arr1[not_equals][:3]} vs {arr2[not_equals][:3]}"
    return same, log


def compare_npy_files(f1, f2, atol=0.00, rtol=0.00):
    if not os.path.isfile(f1) or not os.path.isfile(f2):
        raise Exception(f"One of the files does not exist: {f1}, {f2}!")
    if not f1.endswith('.npy') or not f2.endswith('.npy'):
        raise Exception(f"One of the files is not .npy file: {f1}, {f2}!")
    arr1 = np.load(f1)
    arr2 = np.load(f2)
    same, log = compare_npy_arrays(arr1, arr2, atol=atol, rtol=rtol)
    if same: print(f"GOOD: {f1} and {f2} are the same.")
    else: print(f"NOT GOOD: {f1} and {f2} are NOT same. Log: {log}")


def test_intm_files(model1, model2, atol=0.00, rtol=0.00):
    all_files = os.listdir('./')
    intm_files = [f for f in all_files if f.startswith("debug") and f.endswith(f"{model1}.npy")]
    intm_files = list(set([file_name.replace(f"{model1}.npy", "") for file_name in intm_files]))
    intm_files = sorted(intm_files, key=lambda x: int(x.split("_")[1]))
    for file_name in intm_files:
        f1, f2 = f"{file_name}{model1}.npy", f"{file_name}{model2}.npy"
        compare_npy_files(f1, f2, atol=atol, rtol=rtol)


class Debugger:
    def __init__(self, debugger_name, debug=False, folder="debug"):
        self.debugger_name = debugger_name
        self.debug = debug
        self.debug_id = 0
        self.sim_id = 0
        self.layer_id = 0
        self.folder = folder

    def save(self, name, array, folder='demo', sim=False, layer=False):
        if self.debug:
            if folder in ['embed', 'lm_head']:
                path = f'{self.folder}/{folder}'
            else:
                path = f'{self.folder}/layer{self.layer_id}/{folder}/npy'
            if not os.path.exists(path):
                os.makedirs(path)
            np.save(f"{path}/{name}.npy", np.array(array))
        if layer:
            self.layer_id += 1

    def save_npy(self, name, array, folder='demo'):
        if self.debug:
            path = f'{self.folder}/{folder}/npy'
            if not os.path.exists(path):
                os.makedirs(path)
            np.save(f"{path}/{name}.npy", np.array(array))

    def save_mem(self, name, array, folder='demo', nbits=32, layer=False):
        if self.debug:
            path = f'{self.folder}/{folder}'
            if not os.path.exists(path):
                os.makedirs(path)
            save_mem(f'{path}/{name}.mem', array, nbits)
        if layer:
            self.layer_id += 1

    def save_dict(self, d, folder='demo', nbits=32, save_npy=False, layer=False):
        for k, v in d.items():
            self.save_mem(k, v, folder, nbits)
            if save_npy:
                self.save_npy(k, v, folder)
        if layer:
            self.layer_id += 1

    def append_mem(self, name, array, folder='demo', nbits=32, layer=False):
        if self.debug:
            path = f'{self.folder}/{folder}'
            if not os.path.exists(path):
                os.makedirs(path)
            save_mem(f'{path}/{name}.mem', array, nbits, write='a')
        if layer:
            self.layer_id += 1
