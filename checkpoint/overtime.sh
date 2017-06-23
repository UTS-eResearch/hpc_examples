#!/bin/bash

# Self resubmitting PBS bash script:
# Adapted from: https://opus.nci.org.au/display/Help/How+do+I+submit+self+submitting+jobs
# 
# Usage: qsub -v NJOBS=5 <scriptname>
#
# Details
#
# * Submits a follow-on job before executing the current job. The follow-on 
#   job will be in the "H"eld state until the current job completes.
#
# * Assumes program being run is checkpointing at regular intervals and is
#   able to resume execution from a checkpoint.
#
# * Does not assume the program will complete within the requested time.
#
# * Uses an environment variable (NJOBS) to limit the total number of 
#   resubmissions in the sequence of jobs.
#
# * Allows the early termination of the sequence of jobs - just create/touch
#   the file STOP in the jobs working directory.  This may be done 
#   by the executable program when it has completed the "whole" job or by hand 
#   if there is a problem.
#
# * This script may be renamed anything (<15 characters) but if you use the -N 
#   option to qsub you must edit the qsub line below to give the script name 
#   explicitly.
#
# * Usage: 
#   - make appropriate changes to the PBS options below and to the 
#     execution and file manipulation lines below.
#   - submit the job with the appropriate value of NJOBS, eg:
#
#     qsub -v NJOBS=5 <scriptname>
#
# * To kill a job sequence, either touch the file STOP or qdel
#   the held job followed by the running job.
#
# * To test, try  "sleep 100"  as your executable line.

#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=0:02:00
#PBS -v NJOBS,NJOB
#PBS -q smallq
#PBS -m abe 
#PBS -M Your.Email@uts.edu.au

myjobdir=$HOME/jobs/checkpoint
cd $myjobdir

echo "Starting self submitting jobs ..."

# NJOBS is the total number of jobs in a sequence of jobs (defaults to 1)
if [[ ! $NJOBS =~ ^-?[0-9]+$ ]]; then
    echo "NJOBS (total number of jobs in sequence) is not set - defaulting to 1"
    export NJOBS=1
fi
  
# NJOB is the number of the previous job in the sequence (defaults to 0)
if [[ ! $NJOB =~ ^-?[0-9]+$ ]]; then
    echo "NJOB (previous job number in sequence) is not set - defaulting to 0"
    export NJOB=0
fi

# Quick termination of job sequence - look for a specific file,  
# e.g. the filename could be a qsub -v argument.
if [ -f STOP ]; then
    echo  "Stopping sequence after $NJOB jobs"
    exit 0
fi

# Increment the counter to get current job number
NJOB=$(($NJOB+1))
echo "NJOBS=$NJOBS NJOB=$NJOB"

# Are we in an incomplete job sequence - more jobs to run ?
if [ $NJOB -lt $NJOBS ]; then
    # Submit the next job
    # Assumes -N option not used to change job name.
    NEXTJOB=$(($NJOB+1))
    echo "Submitting job number $NEXTJOB in sequence of $NJOBS jobs"
    # qsub options: 
    # -z Job identifier is not written to standard output.
    # -W additional_attributes 
    #    depend=afterany: arg_list
    #    This job may be scheduled for execution after all jobs in arg_list have finished execution.
    qsub -z -W depend=afterany:$PBS_JOBID $PBS_JOBNAME
    ## Dependency request for job rejected by 419373.pbsserver Unknown Job Id
else
    echo "Running last job in sequence of $NJOBS jobs"
fi

# File manipulation prior to job commencing, eg. clean up previous output files,
# check for consistency of checkpoint files etc ...
if [ $NJOB -gt 1 ]; then
    echo " "
    echo "# .... USER CODE HERE" 
fi

# Now run the job.
echo "Starting job number $NJOB" 
sleep 5
$myjobdir/primes.py 

# Not expected to reach this point in general but if we do, check that all 
# is OK.  If the job command exited with an error, terminate the job.
errstat=$?
if [ $errstat -ne 0 ]; then
    # A brief nap so PBS kills us in normal termination. Prefer to 
    # be killed by PBS if PBS detected some resource excess.
    sleep 5
    echo "Job number $NJOB returned an error status $errstat - stopping job sequence."
    touch STOP
    exit $errstat
fi

echo 'Finished'

