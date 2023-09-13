#!/bin/bash
  
#SBATCH -A general
#SBATCH -J guidance                               # Job name 
#SBATCH -o guidance.%a.%A.out                     # File to which stdout will be written
#SBATCH -e guidance.%a.%A.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 1:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test

# Change path to guidance to the path to your  installation.
# Change path to mafft to the path to your installation (--mafft mafft on line 26)

module load perl


# Create variable to hold the directory name (which is the species name) and move inside folder
alignmentname=$(sed -n "${SLURM_ARRAY_TASK_ID}p" alignment_names_current.txt)

mkdir -p alignments/${alignmentname}
cd alignments/${alignmentname}

perl ./programs/guidance.v2.02/www/Guidance/guidance.pl --seqFile ./mcl_fasta/${alignmentname}.fa --msaProgram MAFFT --seqType codon --bootstraps 100 --mafft mafft --outDir ./ --dataset ${alignmentname}