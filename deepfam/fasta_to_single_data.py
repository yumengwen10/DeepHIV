import argparse
import sys
from Bio import SeqIO

from utils import GPCR_subfamily, GPCR_family, GPCR_label

parser = argparse.ArgumentParser()
parser.add_argument("input", help="path of the folder", type=str)
parser.add_argument("output", help="path of output file", type=str)
parser.add_argument("label", help="name of class", type=str)
parser.add_argument("--length", help="length of seq", type=int, default=1000)

try:
    args = parser.parse_args()


except:
    parser.print_help()
    sys.exit(1)

records = SeqIO.parse(args.input, format='fasta')
with open(args.output, 'w') as fout:
    for record in records:
        seq = str(record.seq)
        if len(seq) > args.length:
            seq = seq[:args.length]

        elif len(seq) < args.length:
            seq = seq + '_' * (args.length - len(seq))

        label = GPCR_label[args.label]
        id = record.id
        print("\t".join([str(label), seq, id]), file=fout)