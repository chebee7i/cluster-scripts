#!/bin/bash
#
# Make sure arrayjob.sh and arrayjob_worker.sh are in your PATH.
#
# Usage: arrayjob.sh JOBNAME NUM WORKER_SCRIPT
#
#  JOBNAME is the job name and basename for stdout, stderr logfiles.
#  NUM specifies how many tasks to run.
#  WORKER_SCRIPT is the path to the script that is to be run.
#
# Example:  arrayjob.sh myarray 6 ./worker.py
#
# This will run
#
#   WORKER_SCRIPT=./worker.py \
#   TASK_ID=X \
#   sbatch -J myarray.X -o myarray.X.%j.o -e myarray.X.%j.e arrayjob_worker.sh
#
# for X=0,1,2,3,4,5. Then, arrayjob_worker.sh will print the date, user,
# hostname, working directory, SLURM job id, and task id. After that,
# it will launch your script as:
#
#    time ./worker.py
#
# So myarray.X.%j.e will contain the output of 'time'.
#
# Make sure worker.py uses TASK_ID to customize the work done.
# Note: The worker script must be executable.
#       (it need not be a Python script)
#
for (( i=0; i<$2; i++ ))
do
    WORKER_SCRIPT=$3 TASK_ID="$i" sbatch -J $1.$i -o $1.$i.%j.o -e $1.$i.%j.e arrayjob_worker.sh
done

