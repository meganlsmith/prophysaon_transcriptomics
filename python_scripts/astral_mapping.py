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

print(len(trees))

dictionary = {}
problem_trees = []

outtrees = open('%s/all_trees.tre' % args.output, 'w')


for item in trees:
    count = 0 
    t = ete3.Tree(os.path.join(args.input, item))
    for leaf in t:
        species = leaf.name.split('@')[0]
        new_name = species + '-' + str(count)
        count+=1
        if species in dictionary and not new_name in dictionary[species]:
            dictionary[species].append(new_name)
        elif species not in dictionary:
            dictionary[species]=[new_name]
        leaf.name = new_name
    outtrees.write(t.write(format=1))
    outtrees.write('\n')

outmap = open(os.path.join(args.output, 'map.txt'), 'w')
for key in dictionary:
    string = ''
    string+=key
    string+=":"
    count=0
    for individual in dictionary[key]:
        if count==0:
            string+=individual
            count+=1
        else:
            string+=','
            string+=individual
    outmap.write(string)
    outmap.write('\n')
outmap.close()
outtrees.close()
