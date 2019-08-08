#! /bin/bash
# usage: series.sh

# Set the total number of jobs
TOTAL_NUMBER_JOBS=4

# Set the stride i.e. the number of time steps
# run by each job
STRIDE=10

# print table header
printf "|%10s|%5s|%5s|%14s|\n" "i" "start" "end" "jobid"

# First job (i=0) is dealt with separately because it
# does not have any dependency
i=0
start=$((i*$STRIDE))
end=$(((i+1)*$STRIDE-1))

previous_jobid=$(sbatch --parsable -N 1 -n 1 -t 00:10:00 one_job.sh $start $end)
printf "|%10d|%5d|%5d|%14d|\n" $i $start  $end $previous_jobid

for((i=1;i<$TOTAL_NUMBER_JOBS;i++))
do
    start=$((i*$STRIDE))
    end=$(((i+1)*$STRIDE-1))

    previous_jobid=$(sbatch --parsable --dependency=afterok:$previous_jobid \
	-N 1 -n 1 -t 00:10:00 one_job.sh $start $end)
    printf "|%10d|%5d|%5d|%14d|\n" $i $((i*$STRIDE)) $(((i+1)*$STRIDE-1)) $previous_jobid
done

