"""Python script to filter alignments:
1. Remove any individuals with > 50% gaps.
2. Remove any alignments with < 4 individuals.
3. Write output to output folder.
"""
# On carbonate, use anaconda environment deeplearning, as it has dendropy already installed.
from Bio import AlignIO
import os

input_folder = 'alignments_g200bp'
output_folder = 'alignments_g200bp_filtered'

os.system('mkdir -p %s' % output_folder)

alignments = os.listdir(input_folder)

for alignment in alignments:

    print(os.path.join(input_folder, alignment))
    charmatrix = AlignIO.read(open(os.path.join(input_folder, alignment)), 'fasta')
    newcharmatrix = AlignIO.MultipleSeqAlignment(records=[])
    for record in charmatrix:
        seq_length = len(record.seq)
        nogaps = record.seq.replace('-','')
        nogap_length = len(nogaps)
        if nogap_length >= 0.5*seq_length:
            newcharmatrix.append(record)
    if len(newcharmatrix) >= 4:
        AlignIO.write(newcharmatrix, os.path.join(output_folder, alignment), format="fasta")
