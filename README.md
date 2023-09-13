# prophysaon_transcriptomics
 
## Phylogenetics

1. Concatenate all CDS sequences into all.fa for building local blast database.
    cat folder/*.fa > all.fa
    NOTE: Change folder to the name of the folder with your input files (folder)

2. BLAST
    sbatch bash_scripts/allbyall.sh

3. blast to mcl (format output for running mcl)
    sbatch bash_scripts/blast_to_mcl.sh

4. mcl (run mcl) 
    sbatch bash_scripts/mcl.sh

5. MCL to fasta
    sbatch bash_scripts/mcl_to_fasta.sh

6. Alignment with GUIDANCE2 in conjunction with MAFFT
    sbatch bash_scripts/guidance_master.sh
    # NOTE: This script submits lots of bash jobs. You'll need some other files (see slurm script for details).

7. Make sure all alignments finished
    bash bash_scripts/check_alignments.sh
    # NOTE: If names are printed, then those alignments were not completed, and you'll need to rerun them. This shouldn't happen unless there is an issue with the HPC, but since the previous script submits so many jobs, it can be hard to tell what failed.

8. TrimAI
    sbatch bash_scripts/trimal.sh

9. Keep only those alignments greater than 200 bp
    bash keeplongalignments.sh

10. Filter alignments by removing individuals with more than 50% gaps and alignmetns with < 4 individuals
    python python_scripts/filteralignments.py

11. Infer Gene Trees
    sbatch ./bash_scripts/gene_trees.sh
    cd gene_trees
    mkdir trees
    mv *.treefile trees

12. Rename gene trees and check for issues
    # NOTE: THIS WILL NOT WORK FOR GENERIC INPUT. It is fairly specific to my application, but you may need to do similar things for downstream inferences to work correctly. 
    # For downstream scripts to work, taxa must be named as follows: 
    # The first part of the name should be the same for any gene sequences sampled from that taxon, and it should be seperated from everything else by an '@'.
    # This script will almost certainly not accomplish that for your data.
    python ./python_scripts/check_trees.py

13. Prep Astral-Pro input
    mkdir astral_pro
    python ./python_scripts/apro_mapping.py --input ./gene_trees/renamed_trees/ --output astral_pro

14. Run ASTRAL Pro
    sbatch ./bash_scripts/apro.sh

15. Prep Astral input
    mkdir -p astral/all
    python ./python_scripts/astral_mapping.py --input ./gene_trees/renamed_trees/ --output astral/all

16. Run ASTRAL
    sbatch ./bash_scripts/astral.sh

17. ASTRAL-DISCO
    mkdir disco
    sbatch bash_scripts/disco.sh
    sbatch bash_scripts/astral-disco.sh

18. CA-DISCO
    mkdir cadisco
    sbatch bash_scripts/cadisco.sh
    python ./python_scripts/prep_cadisco.py --input ./gene_trees/renamed_trees/ --output ./cadisco/ --alignments ./alignments_g200bp_filtered/
    python /N/u/mls16/Carbonate/Programs/DISCO/ca_disco.py -i ./cadisco/all_trees.tre -a ./cadisco/all_alignments.txt -t ./cadisco/all_taxa.txt -o ./cadisco/decomposed.fa -d @

19. IQTree on CA-DISCO
    sbatch ./bash_scripts/ca_iqtree.sh

20. Yang and Smith datasets creation
    sbatch ./bash_scripts/ys.sh


21. ASTRAL set up for YS datasets.
    sbatch ./bash_scripts/astral_setup_ys.sh

22. Run ASTRAL
    sbatch ./bash_scripts/astral_sco.sh
    sbatch ./bash_scripts/astral_mi.sh
    sbatch ./bash_scripts/astral_mo.sh

23. Concatenated datasets for YS datasets.
    sbatch ./bash_scripts/concatenate_sco.sh
    sbatch ./bash_scripts/concatenate_mi.sh
    sbatch ./bash_scripts/concatenate_mo.sh

24. Run IQTree on YS datasets
    mkdir iqtree_ys
    sbatch ./bash_scripts/sco_iqtree.sh
    sbatch ./bash_scripts/mi_iqtree.sh
    sbatch ./bash_scripts/mo_iqtree.sh

