"""Take as input a folder with gene trees. Create the following CA-DISCO input files: list of alignment files, list of taxa."""

import argparse
import os
import ete3

parser = argparse.ArgumentParser(description='Process input and output folders')
parser.add_argument('--input', dest="input", type=str,
                    help='an input folder gene trees to analyze.')
parser.add_argument('--output', dest="output", type=str, 
                    help='an output folder.')
parser.add_argument('--alignments', dest="alignments", type=str,
                    help='an alignment folder.')
args = parser.parse_args()

trees = os.listdir(args.input)


dictionary = {}
problem_trees = []

outtrees = open('%s/all_trees.tre' % args.output, 'w')
outalignments = open('%s/all_alignments.txt' % args.output, 'w')
outtaxa = open('%s/all_taxa.txt' % args.output, 'w')
taxonlist = []
for item in trees:
    
    t = ete3.Tree(os.path.join(args.input, item))
    outtrees.write(t.write())
    outtrees.write('\n')

    outalignments.write('%s%s\n' % (args.alignments, (item.split('.treefile')[0] + '.trimAl.aln')))
    
    for leaf in t:
        taxonlist.append(leaf.name)

outtrees.close()
outalignments.close()
species = []
for item in set(taxonlist):
    species.append(item.split('@')[0])
for item in set(species):
    outtaxa.write(item)
    outtaxa.write('\n')

outtaxa.close()
