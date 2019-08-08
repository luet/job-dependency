#! /bin/bash
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 00:10:00

./one_job.sh $START $END
