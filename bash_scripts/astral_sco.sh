#!/bin/bash

#SBATCH -A general
#SBATCH -J Astral                         # Job name 
#SBATCH -o Astral.%a.%A.out                    # File to which stdout will be written
#SBATCH -e Astral.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 1:00                             # Runtime in DD-HH:MM
#SBATCH -p general                              # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to astral to the path to your installation.

module load java
java -D"java.library.path=programs/Astral/lib" -jar programs/Astral/astral.5.7.3.jar -i ./astral/sco_ys/all_trees.tre -o ./astral/sco_ys/astral_sco.tre  


