#!/bin/bash

#SBATCH -A general
#SBATCH -J concat                         # Job name 
#SBATCH -o concat.%a.%A.out                    # File to which stdout will be written
#SBATCH -e concat.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 2:00:00                             # Runtime in DD-HH:MM
#SBATCH --mem=250Gb
#SBATCH -p general                              # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.

module load python
mkdir mo_ys_alignments
python ./python_scripts/ys_concatenate.py --input ./mo_ys/ --output ./mo_ys_alignments --alignments ./alignments_g200bp_filtered/

