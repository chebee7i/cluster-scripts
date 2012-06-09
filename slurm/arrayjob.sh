#!/bin/bash
#
# Usage: ./arrayjob.sh JOBNAME NUMTASKS WORKERSCRIPT
#
#  JOBNAME is the job name and basename for stdout, stderr logfiles.
#  NUM specifies how many tasks to run.
#  WORKERSCRIPT should the path to the script to be run.
#
# Example:  ./arrayjob.sh myarray 6 ./worker.py
#
# This will run
#
#   WORKER_SCRIPT=worker.py \
#   TASK_ID=X \
#   sbatch -J myarray.X -o myarray.X.%j.o -e myarray.X.%j.e arrayjob_worker.sh
#
# for X=0,1,2,3,4,5. Then, arrayjob_worker.sh will print the date, user,
# hostname, working directory, SLURM job id, and task id. After that,
# it will launch your script as:
#
#    time $WORKER_SCRIPT
#
# So myarray.X.%j.e will contain the output of 'time'.
# Note: worker.py must be executable (it need not be a Python script either).

for (( i=0; i<$2; i++ ))
do
    WORKER_SCRIPT=$3 TASK_ID="$i" sbatch -J $1.$i -o $1.$i.%j.o -e $1.$i.%j.e arrayjob_worker.sh
done

