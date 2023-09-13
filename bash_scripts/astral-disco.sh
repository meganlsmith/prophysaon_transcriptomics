#!/bin/bash

#SBATCH -A general
#SBATCH -J Astral                         # Job name 
#SBATCH -o Astral.%a.%A.out                    # File to which stdout will be written
#SBATCH -e Astral.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 00-10:00                             # Runtime in DD-HH:MM
#SBATCH --mem 250G                              # Memory for all cores in Mbytes (--mem-per-cpu for MPI jobs)
#SBATCH -p general                              # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to astral to the path to your installation.

cd ./disco/
java -D"java.library.path=programs/Astral/lib" -jar programs/Astral/astral.5.7.3.jar -i disco_trees.tre -o astral_disco.tre
cd ../

