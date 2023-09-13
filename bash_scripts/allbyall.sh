#!/bin/bash
  
#SBATCH -J blast_db                              # Job name 
#SBATCH -o blast_db.%j.out                     # File to which stdout will be written
#SBATCH -e blast_db.%j.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 12                                    # Number of cores/cpus
#SBATCH -t 10:00:00                             # Runtime in DD-HH:MM
#SBATCH --mem 5000                              # Memory for all cores in Mbytes (--mem-per-cpu for MPI jobs)
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test

# Change email address to yours

module load blast/2.9.0

mkdir -p blast_database
mkdir -p allbyall

makeblastdb -in all.fa -parse_seqids -input_type fasta -dbtype nucl -out blast_database/all.fa

blastn -db blast_database/all.fa -query all.fa -evalue 10 -num_threads 12 -max_target_seqs 1000 -out ./allbyall/all.rawblast -outfmt '6 qseqid qlen sseqid slen frames pident nident length mismatch gapopen qstart qend sstart send evalue bitscore'