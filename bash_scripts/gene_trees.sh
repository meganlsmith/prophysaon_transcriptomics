#!/bin/bash

#SBATCH -A general
#SBATCH -J iqtree                               # Job name 
#SBATCH -o iqtree.%a.%A.out                     # File to which stdout will be written
#SBATCH -e iqtree.%a.%A.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 10:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to iqtree to the path for your installation

mkdir -p gene_trees


for d in alignments_g200bp_filtered/* ;
do
    IFS=/ read var1 name <<< $d;
    IFS=. read name var1 var2 <<< $name;
    ./programs/iqtree-2.0.6-Linux/bin/iqtree2 -s $d -m MFP -pre gene_trees/$name
done







