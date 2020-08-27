#!/bin/bash

# Example of a typical qsub submission script for the primes program.
# This uses the /scratch directory which is probably what you should be using.
#
# Important: 
#   In this example we have used a staff/student number of 999777.
#   You will need to change all instances of this to your own 
#   staff/student number before you try and run this script. 
#
# Run this as qsub scriptname
#
# Author: Mike Lake

##################
# Set PBS Commands 
#################

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 

# There are several queues e.g. workq, smallq and others. 
# If you don't specify a queue your job will be routed to an appropriate queue.  
#PBS -q smallq

# Send email on abort, begin and end. 
# CHANGE 999777 to your staff or student number!
#PBS -m abe 
#PBS -M 999777@uts.edu.au

###################################
# Setup any input files for the run
###################################
  
# If you have any input files then create your own directory under the 
# "/scratch/" directory and copy your input files to there. 
# Note: This scratch directory will be on the node that the job has 
# been submitted to by PBS. 

# The shell parameters which are useful are:
#   USER which is the name of the logged in user (e.g. 999777), 
#   PBS_JOBID which is the job ID of this PBS job (e.g. 184327.hpcnode0) and 
#   PBS_JOBID%.* is a bash parameter expansion. See "Parameter Expansion" in "man bash".
# 
# For instance if PBS_JOBID is 184327.hpcnode0 then PBS_JOBID%.* will be just 184327.
# Hence the scratch directory created will be /scratch/999777_184327
# This will be unique for every PBS job you submit.

SCRATCH="/scratch/${USER}_${PBS_JOBID%.*}"
mkdir ${SCRATCH}

# Change to the PBS working directory where qsub was started from.
# Copy your input files from there to the scratch directory you just created.
# The shell parameter PBS_O_WORKDIR is the working directory where this job was started from.
cd ${PBS_O_WORKDIR}
if [ -f primes.txt ]; then 
    cp primes.txt ${SCRATCH}
fi

###############
# Start the Job
###############

# Change to the scratch directory where you copied your input 
# files to before you start. Then run the primes program.
cd ${SCRATCH}
${PBS_O_WORKDIR}/primes.py

#####################################################
# Copy results back to your own directory and cleanup
#####################################################

# Move your data back to your working directory.
mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

# We don't want to have old scratch directories hanging around
# so after copying your data back, remove the scratch directory. 
cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

