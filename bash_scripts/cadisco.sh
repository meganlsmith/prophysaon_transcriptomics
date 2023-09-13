#!/bin/bash

#SBATCH -A general
#SBATCH -J cadisco                         # Job name 
#SBATCH -o cadisco.%a.%A.out                    # File to which stdout will be written
#SBATCH -e cadisco.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 00-10:00                             # Runtime in DD-HH:MM
#SBATCH --mem 250G                              # Memory for all cores in Mbytes (--mem-per-cpu for MPI jobs)
#SBATCH -p general                              # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to disco to your installations.

module load python
python ./python_scripts/prep_cadisco.py --input ./gene_trees/renamed_trees/ --output ./cadisco/ --alignments ./alignments_g200bp_filtered/
python programs/DISCO/ca_disco.py -i ./cadisco/all_trees.tre -a ./cadisco/all_alignments.txt -t ./cadisco/all_taxa.txt -o ./cadisco/decomposed.fa -d @

