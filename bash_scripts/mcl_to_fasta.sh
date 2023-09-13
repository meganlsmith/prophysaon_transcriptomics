#!/bin/bash
  
#SBATCH -J mcl                              # Job name 
#SBATCH -o mcl.%j.out                     # File to which stdout will be written
#SBATCH -e mcl.%j.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                   # Number of cores/cpus
#SBATCH -t 10:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test

# Change email address to yours.
# The write_fasta_files_from_mcl.py script is from Yang and Smith (https://bitbucket.org/yanglab/phylogenomic_dataset_construction/src/master/), make sure you cite it.
# Change path of Yang and Smith script to your installation.

module load python/2.7.latest
python programs/phylogenomic_dataset_construction/scripts/write_fasta_files_from_mcl.py ./pre-blast/all.fa mcl/mammals_f0.4_I1.4_e5 4 ./mcl_fasta/