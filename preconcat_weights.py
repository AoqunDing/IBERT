import json
import numpy as np
from collections import OrderedDict
from utils import load_model, load_weights


def main():
    BLOCKS_HEAD = 8
    BLOCKS_SELF = 192
    BLOCKS_INTER = 768
    BLOCKS_LAYER = 192

    config = dict(
        n_tokens = 32,
        n_layers = 12,
        n_heads = 12,
        embed_size = 768,
        head_size = 64
    )

    loaded_sd = load_model("data/model_np.bin", "data/model_np.json")
    loaded_weights = load_weights(state_dict=loaded_sd, **config)
    concated_weights = OrderedDict()

    for layer_id in range(config['n_layers']):
        for head_id in range(config['n_heads']):
            loaded_weights[f"layer{layer_id}_head{head_id}"]['W_Q'] = np.concatenate(
                np.array_split(loaded_weights[f"layer{layer_id}_head{head_id}"]['W_Q'],BLOCKS_HEAD,axis=1))
            loaded_weights[f"layer{layer_id}_head{head_id}"]['W_K'] = np.concatenate(
                np.array_split(loaded_weights[f"layer{layer_id}_head{head_id}"]['W_K'],BLOCKS_HEAD,axis=1))
            loaded_weights[f"layer{layer_id}_head{head_id}"]['W_V'] = np.concatenate(
                np.array_split(loaded_weights[f"layer{layer_id}_head{head_id}"]['W_V'],BLOCKS_HEAD,axis=1))
            concated_weights[f"layer{layer_id}_head{head_id}"] = np.concatenate(
                [loaded_weights[f"layer{layer_id}_head{head_id}"][key].flatten() for key in 
                ['W_Q', 'bias_Q', 'Q_m', 'Q_e', 'W_K', 'bias_K', 'K_m', 'K_e', 'W_V', 'bias_V', 'V_m', 'V_e', 'C_m', 'C_e']])

        loaded_weights[f"layer{layer_id}_self_out"]['W'] = np.concatenate(
            np.array_split(loaded_weights[f"layer{layer_id}_self_out"]['W'],BLOCKS_SELF,axis=1))
        concated_weights[f"layer{layer_id}_self_out0"] = np.concatenate(
            [loaded_weights[f"layer{layer_id}_self_out"][key].flatten() for key in ['W', 'R_m', 'R_e']])
        concated_weights[f"layer{layer_id}_self_out1"] = np.concatenate(
            [loaded_weights[f"layer{layer_id}_self_out"][key].flatten() for key in ['W_bias', 'W_m', 'W_e', 'ln_bias', 'out_m', 'out_e']])

        loaded_weights[f"layer{layer_id}_inter"]['W'] = np.concatenate(
            np.array_split(loaded_weights[f"layer{layer_id}_inter"]['W'],BLOCKS_INTER,axis=1))
        concated_weights[f"layer{layer_id}_inter"] = np.concatenate(
            [loaded_weights[f"layer{layer_id}_inter"][key].flatten() for key in ['W_bias', 'out_m', 'out_e', 'W']])

        loaded_weights[f"layer{layer_id}_layer_out"]['W'] = np.concatenate(
            np.array_split(loaded_weights[f"layer{layer_id}_layer_out"]['W'],BLOCKS_LAYER,axis=1))
        concated_weights[f"layer{layer_id}_layer_out0"] = np.concatenate(
            [loaded_weights[f"layer{layer_id}_layer_out"][key].flatten() for key in ['W', 'R_m', 'R_e']])
        concated_weights[f"layer{layer_id}_layer_out1"] = np.concatenate(
            [loaded_weights[f"layer{layer_id}_layer_out"][key].flatten() for key in ['W_bias', 'W_m', 'W_e', 'ln_bias', 'out_m', 'out_e']])

    # Save metadata to JSON
    metadata = {key: value.shape for key, value in concated_weights.items()}
    with open('weights.json', 'w') as f:
        json.dump(metadata, f)
    
    # Save binary weights data
    with open('weights.bin', 'wb') as f:
        for value in concated_weights.values():
            f.write(value.tobytes())
    
    # Sanity check
    # Load metadata from JSON
    with open('weights.json', 'r') as f:
        loaded_metadata = json.load(f)

    with open('weights.bin', 'rb') as f:
        for key, shape in loaded_metadata.items():
            size = int(np.prod(shape))
            data = np.frombuffer(f.read(size * 4), dtype=np.int32).reshape(shape)
            assert np.array_equal(data, concated_weights[key])


if __name__ == "__main__":
    main()

