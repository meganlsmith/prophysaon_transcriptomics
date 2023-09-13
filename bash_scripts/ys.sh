#!/bin/bash

#SBATCH -A general
#SBATCH -J ys                         # Job name 
#SBATCH -o ys.%a.%A.out                    # File to which stdout will be written
#SBATCH -e ys.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 00-10:00                             # Runtime in DD-HH:MM
#SBATCH --mem 250G                              # Memory for all cores in Mbytes (--mem-per-cpu for MPI jobs)
#SBATCH -p general                              # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to yang and smith scripts to your installations.

module load python/2.7.latest

# preprocessing
python2 programs/phylogenomic_dataset_construction/scripts/mask_tips_by_taxonID_transcripts.py ./gene_trees/renamed_trees/ ./alignments_g200bp_filtered/ y

mkdir gene_trees/masked_trees/
mv gene_trees/renamed_trees/*.mm ./gene_trees/masked_trees/
mkdir gene_trees/ys_fasta/

python2 programs/phylogenomic_dataset_construction/scripts/write_fasta_files_from_trees.py ./phylogenomics_renamed/all.fa ./gene_trees/masked_trees .mm ./gene_trees/ys_fasta/

# SCO
mkdir sco_ys
python2 programs/phylogenomic_dataset_construction/scripts/filter_1to1_orthologs.py ./gene_trees/masked_trees/ .mm 4 ./sco_ys

# MI
mkdir mi_ys
python2 programs/phylogenomic_dataset_construction/scripts/prune_paralogs_MI.py ./gene_trees/masked_trees/ .mm 0.4  0.4 4 ./mi_ys

# MO
mkdir mo_ys
python2 programs/phylogenomic_dataset_construction/scripts/prune_paralogs_MO.py ./gene_trees/masked_trees/ .mm 4 ./mo_ys taxon_file_ys.txt
