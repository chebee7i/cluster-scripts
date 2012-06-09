#!/bin/bash
#
# Worker script for arrayjob.
#
echo `date`
echo
echo "User: $USER"
echo "Hostname:" `hostname`

echo
echo "Working Directory:" `pwd`
echo "Command: $WORKER_SCRIPT"
echo
echo "SLURM Job: $SLURM_JOB_ID"
echo "Task Id: $TASK_ID"
echo
echo "-----"
time $WORKER_SCRIPT
