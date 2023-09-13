#!/bin/bash

#SBATCH -A general
#SBATCH -J IQTree                         # Job name 
#SBATCH -o IQTree.%a.%A.out                    # File to which stdout will be written
#SBATCH -e IQTree.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 96:00:00                             # Runtime in DD-HH:MM
#SBATCH --mem 250G                             # Memory for all cores in Mbytes (--mem-per-cpu for MPI jobs)
#SBATCH -p general                            # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to IQTree to your path

programs/iqtree-2.0.6-Linux/bin/iqtree2 -s ./cadisco/decomposed.fa -m MFP -B 1000 --prefix ./cadisco/discoiq

