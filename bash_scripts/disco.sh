#!/bin/bash

#SBATCH -A general
#SBATCH -J disco                         # Job name 
#SBATCH -o disco.%a.%A.out                    # File to which stdout will be written
#SBATCH -e disco.%a.%A.err                    # File to which stderr will be written
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
python programs/DISCO/disco.py -i ./astral_pro/all_trees.tre -o ./disco/disco_trees.tre

