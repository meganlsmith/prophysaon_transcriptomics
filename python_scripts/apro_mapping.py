"""Take as input a folder with gene trees. Create ASTRAL-Pro input files."""

import argparse
import os
import ete3

parser = argparse.ArgumentParser(description='Process input and output folders')
parser.add_argument('--input', dest="input", type=str,
                    help='an input folder gene trees to analyze.')
parser.add_argument('--output', dest="output", type=str, 
                    help='an output folder.')
args = parser.parse_args()

trees = os.listdir(args.input)
dictionary = {}
problem_trees = []
outtrees = open('%s/all_trees.tre' % args.output, 'w')

for item in trees:
    t = ete3.Tree(os.path.join(args.input, item))
    for leaf in t:
        species = leaf.name.split('@')[0]
        leaf.name = species
    outtrees.write(t.write())
    outtrees.write('\n')

outtrees.close() 
