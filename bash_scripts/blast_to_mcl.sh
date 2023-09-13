#!/bin/bash
  
#SBATCH -J blast_to_mcl                              # Job name 
#SBATCH -o blast_to_mcl.%j.out                     # File to which stdout will be written
#SBATCH -e blast_to_mcl.%j.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                   # Number of cores/cpus
#SBATCH -t 10:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test


# Change email address to yours.
# I used hit fractions of 0.3 and 0.4, you may want to do something else.
# The blast-to-mcl.py script is from Yang and Smith (https://bitbucket.org/yanglab/phylogenomic_dataset_construction/src/master/), make sure you cite it.
# Change path to Yang And Smith scripts to your installation

module load python/2.7.latest
python programs/phylogenomic_dataset_construction/scripts/blast_to_mcl.py ./allbyall/all.rawblast 0.3
python programs/phylogenomic_dataset_construction/scripts/blast_to_mcl.py ./allbyall/all.rawblast 0.4