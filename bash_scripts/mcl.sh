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
# I'm doing four combos of hit fraction and inflation factor. You could use different numbers and do different combos.

module load mcl
mkdir -p mcl
mcl allbyall/all.rawblast.hit-frac0.4.minusLogEvalue --abc -te 5 -tf 'gq(5)' -I 1.4 -o mcl/hit-frac0.4_I1.4_e5
mcl allbyall/all.rawblast.hit-frac0.4.minusLogEvalue --abc -te 5 -tf 'gq(5)' -I 2 -o  mcl/hit-frac0.4_I2_e5
mcl allbyall/all.rawblast.hit-frac0.3.minusLogEvalue --abc -te 5 -tf 'gq(5)' -I 1.4 -o  mcl/hit-frac0.3_I1.4_e5
mcl allbyall/all.rawblast.hit-frac0.3.minusLogEvalue --abc -te 5 -tf 'gq(5)' -I 2 -o  mcl/hit-frac0.3_I2_e5