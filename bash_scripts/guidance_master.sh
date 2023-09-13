#!/bin/bash
  
#SBATCH -A general
#SBATCH -J guidance_m                              # Job name 
#SBATCH -o guidance_m.%a.%A.out                     # File to which stdout will be written
#SBATCH -e guidance_m.%a.%A.err                     # File to which stderr will be written
#SBATCH --mail-type=ALL                         # BEGIN,END,ALL
#SBATCH --mail-user=email@indiana.edu           # Email address
#SBATCH -N 1                                    # Ensure that all cores are on one machine
#SBATCH -n 1                                    # Number of cores/cpus
#SBATCH -t 96:00:00                             # Runtime in DD-HH:MM
#SBATCH -p general                               # Partition shared, serial_requeue, unrestricted, test

# Change the email to your email address
# This is almost certainly not the most efficient way to do this.
# The script will submit alignments up to 399 jobs, and then will wait until your queue is down to zero and do it again until all jobs have been run
# submitted is set to the number of jobs already submitted (in case something goes wrong and you need to resubmit)
# Total needs to be set to the total number of alignments
# You also text file called alignment_names.txt which lists all of your alignment names (one per line).
# This script assumes you have the script guidance.sh in the directory bash_scripts.

submitted=0
number=399
rep=0
total=12418

while (($submitted < (($total-$number))))
do

    # build the array tx tfile
    head -n $((submitted+number)) alignment_names.txt | tail -n $number > alignment_names_current.txt;

    sentence=$(sbatch --array=1-$number ./bash_scripts/guidance.sh);
    stringarray=($sentence)                            # separate the output in words
    jobid=(${stringarray[3]})                          # isolate the job ID
    sentence="$(squeue -j $jobid)"            # read job's slurm status
    stringarray=($sentence)
    jobstatus=(${stringarray[12]})            # isolate the status of job number jobid

    while [ "$jobstatus" == "PD" ];
    do
        sleep 3600;
        sentence="$(squeue -j $jobid)"            # read job's slurm status
        stringarray=($sentence)
        jobstatus=(${stringarray[12]})            # isolate the status of job number jobid
    done

    while [ "$jobstatus" == "R" ];
    do
        sleep 3600;
        sentence="$(squeue -j $jobid)"            # read job's slurm status
        stringarray=($sentence)
        jobstatus=(${stringarray[12]})            # isolate the status of job number jobid

    done
    rm alignment_names_current.txt;

    # increment counters
    rep=$((rep+1));
    submitted=$((submitted+number));

done
head -n $total alignment_names.txt | tail -n $(($total-submitted)) > alignment_names_current.txt;
sbatch --array=1-$((total-submitted)) ./bash_scripts/guidance.sh;
rm alignment_names_current.txt;