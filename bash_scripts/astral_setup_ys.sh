#!/bin/bash

#SBATCH -A general
#SBATCH -J astral_setup                         # Job name 
#SBATCH -o astral_setup.%a.%A.out                    # File to which stdout will be written
#SBATCH -e astral_setup.%a.%A.err                    # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@iu.edu   # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 00-10:00                             # Runtime in DD-HH:MM
#SBATCH --mem 250G                              # Memory for all cores in Mbytes (--mem-per-cpu for MPI jobs)
#SBATCH -p general                              # Partition shared, serial_requeue, unrestricted, test

# Change email to your email.
# Change path to yang and smith scripts to your installations.

module load python

mkdir astral/sco_ys
mkdir astral/mi_ys
mkdir astral/mo_ys
python ./python_scripts/astral_mapping_ys.py --input ./sco_ys/ --output ./astral/sco_ys/
python ./python_scripts/astral_mapping_ys.py --input ./mi_ys/ --output ./astral/mi_ys/
python ./python_scripts/astral_mapping_ys.py --input ./mo_ys/ --output ./astral/mo_ys/
