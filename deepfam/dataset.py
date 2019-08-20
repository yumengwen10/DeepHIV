from torch.utils import data
import pandas as pd
import numpy as np

CHARSET = {'C': 0, 'G': 1, 'T': 2, 'A': 3, 'N': 4}
CHARLEN = 5

def encoding_seq_np(seq, arr):
    for i, c in enumerate(seq):
        if c == "_" or c == "*":
            # let them zero
            continue
        elif isinstance(CHARSET[c], int):
            idx = CHARSET[c]
            arr[i][idx] = 1
        else:
            idx1 = CHARSET[c][0]
            idx2 = CHARSET[c][1]
            arr[i][idx1] = 0.5
            arr[i][idx2] = 0.5

class PepseqDataset(data.Dataset):
    def __init__(self, file_path, type='train', seq_len = 250):
        self.type = type
        self.file = file_path
        self.seq_len = 550
        # column 0 is label, column 1 is seq
        df = pd.read_csv(self.file, sep='\t', header = None)
        self.labels = df[0]
        self.seqs = df[1]

    def __len__(self):
        return len(self.seqs)

    def __getitem__(self, index):
        seq_np = np.zeros((self.seq_len, CHARLEN), dtype=np.float32)
        encoding_seq_np(self.seqs[index], seq_np)
        return seq_np, self.labels[index]
