#!/bin/bash
  
#SBATCH -A general
#SBATCH -J trimal                             # Job name 
#SBATCH -o trimal.%a.%A.out                     # File to which stdout will be written
#SBATCH -e trimal.%a.%A.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 5:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test

# Change email address to yours.
# Change the path to trimal to the path to your installation. 

for d in alignments/* ;
do
    IFS=/ read var1 name <<< $d;
    ./programs/trimAl/source/trimal -in $d/$name.MAFFT.Without_low_SP_Col.With_Names -out $d/$name.trimAl.aln -gt 0.5
done

