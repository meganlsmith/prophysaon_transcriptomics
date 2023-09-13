"""This file will check all gene trees in the input folder, make sure they have the correct taxa names, and rename taxa to SP_IND@genename for downstream inference."""
import os
import ete3

input_tree_folder = './gene_trees/trees'
output_tree_folder = './gene_trees/renamed_trees'


os.system('mkdir -p %s' % output_tree_folder)

input_trees = os.listdir(input_tree_folder)

for tree in input_trees:
    leaves = []
    t = ete3.Tree(input_tree_folder + '/' + tree)
    for leaf in t:
        leaves.append(leaf.name)
        if 'Avulgaris' in leaf.name:
            sp_name = leaf.name.split('_')[0] + '_' + leaf.name.split('_')[1] 
            gene_name = '_'.join(leaf.name.split('_')[2:len(leaf.name.split('_'))])
            new_name = sp_name + '@' + gene_name
        else:
            sp_name = leaf.name.split('_')[0] + '_' + leaf.name.split('_')[1] + '_' + leaf.name.split('_')[2]
            gene_name = '_'.join(leaf.name.split('_')[3:len(leaf.name.split('_'))])
            new_name = sp_name + '@' + gene_name
        leaf.name = new_name
    bad_leaves = [x for x in leaves if 'seq' in x]
    if len(bad_leaves) > 0:
        print('There is a problem with tree %s' % tree)
    t.write(outfile="%s/%s" % (output_tree_folder, tree))
    

    
