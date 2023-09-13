"""This script will make concatenated alignments from the YS genes."""


import argparse
import os
import ete3
from Bio import AlignIO
from amas import AMAS

parser = argparse.ArgumentParser(description='Process input and output folders')
parser.add_argument('--input', dest="input", type=str,
                    help='an input folder gene trees to analyze.')
parser.add_argument('--output', dest="output", type=str,
                    help='an output folder.')
parser.add_argument('--alignments', dest="alignments", type=str,
                    help='a folder with alignments.')
args = parser.parse_args()

trees = os.listdir(args.input)

print(len(trees))

alignments_to_concatenate = []

for file in trees:
    if '1to1' in file:
        alignment_name = args.alignments + '/' + file.split('.')[0].split('_')[0] + '.trimAl.aln'
        alignment = AlignIO.read(open(alignment_name), 'fasta')
        newalignment = []
        for record in alignment:
            record.id = record.id.split('@')[0]
            record.name = record.id
            record.description = record.id
            newalignment.append(record)
        new_alignment_object = AlignIO.MultipleSeqAlignment(newalignment)
        AlignIO.write([new_alignment_object], args.output + '/' + file.split('.')[0].split('_')[0] + '.trimAl.fasta', 'fasta')
        alignments_to_concatenate.append(args.output + '/' + file.split('.')[0].split('_')[0] + '.trimAl.fasta')
    else:
        alignment_name = args.alignments + '/' + file.split('.')[0].split('_')[0] + '.trimAl.aln'
        alignment = AlignIO.read(open(alignment_name), 'fasta')
        newalignment = [] 
        tree = ete3.Tree(args.input + '/' + file)
        taxa = tree.get_leaf_names()
        for record in alignment:
            if record.id in taxa:
                record.id = record.id.split('@')[0]
                record.name = record.id
                record.description = record.id
                newalignment.append(record)
        new_alignment_object = AlignIO.MultipleSeqAlignment(newalignment)
        AlignIO.write([new_alignment_object], args.output + '/' + file.split('.')[0].split('_')[0] + '.trimAl.fasta', 'fasta')
        alignments_to_concatenate.append(args.output + '/' + file.split('.')[0].split('_')[0] + '.trimAl.fasta')

# concatenated alignment
multi_meta_aln = AMAS.MetaAlignment(in_files=alignments_to_concatenate, data_type="dna", in_format="fasta", cores=1) 
parsed_alns = multi_meta_aln.get_parsed_alignments()
concat_tuple = multi_meta_aln.get_concatenated(parsed_alns)
concatenated_alignments = concat_tuple[0]
concatenated_partitions = concat_tuple[1]
print(concatenated_alignments.keys())
ntax = len(concatenated_alignments.keys())
nchar = len(concatenated_alignments['Avulgaris_SRR13300037'])
nexus_out = open(args.output + '/concatenated.nex', 'w')
nexus_out.write("#NEXUS\n")
nexus_out.write("Begin data;\n")
nexus_out.write("Dimensions ntax=%r nchar=%r;\n" % (ntax, nchar))
nexus_out.write("Format datatype=DNA gap=-;\n")
nexus_out.write("Matrix\n")
for item in concatenated_alignments:
    towrite = item + '          '
    towrite = towrite+ concatenated_alignments[item]
    nexus_out.write(towrite)
    nexus_out.write('\n')
nexus_out.write(';\nEND;\n\n')
nexus_out.write('begin sets;\n')
for item in concatenated_partitions:
    towrite = 'CHARSET ' + item + "=" + concatenated_partitions[item] + ';'
    nexus_out.write(towrite)
    nexus_out.write('\n')
nexus_out.write('END;\n')
nexus_out.close()
