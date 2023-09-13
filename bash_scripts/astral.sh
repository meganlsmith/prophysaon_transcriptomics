#!/bin/bash

#SBATCH -A general
#SBATCH -J Astral                         # Job name 
#SBATCH -o Astral.%a.%A.out                    # File to which stdout will be written
#SBATCH -e Astral.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 24:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general
#SBATCH --mem=250Gb

# Change email to your email.
# Change path to astral to path to your installation.

cd ./astral/
module load java
java -D"java.library.path=programs/Astral/lib" -jar programs/Astral/astral.5.7.3.jar -i ./all/all_trees.tre -a ./all/map.txt -o ./all/astral_all.tre  
cd ../

