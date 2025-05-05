#!/bin/bash

# Example of a typical qsub submission script for the primes program.
# This uses the /scratch directory which is what you should be using.
#
# Important:
#   If you wish this script to email you when the job has started and ended
#   then you will need to remove the extra # from the start of the two lines
#   ##PBS -m and ##PBS -M and edit the latter to your own email.
#
# Run this as: qsub submit_typical.sh
#
# Author: Mike Lake

##################
# Set PBS Commands
##################

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
# We also have named our job "primes". You will see this in the qstat job list.
#PBS -N primes
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00

# Send email on abort, begin and end.
# CHANGE your.email to your email and remove the extra # from the start of the next two lines.
# More than one # characters before a PBS line acts to comment out that line.
##PBS -m abe
##PBS -M Your.Email@uts.edu.au

###################################
# Setup any input files for the run
###################################

# If you have any large input or output files then they need to be read and written
# to the nodes local /scratch directory. So you need to:
# 1. create this /scratch directory
# 2. copy your input files to there
# 3. copy your output files from there, back to your home directory.
# Note: This scratch directory will only be on the node that the job has
# been assigned to by PBS.

# There are some shell parameters which are useful for creating a unique
# scratch directory. These are:
#   USER which is the name of the logged in user (e.g. u999777),
#   PBS_JOBID which is the job ID of this PBS job (e.g. 184327.hpcnode0) and
#   PBS_JOBID%.* is a bash parameter expansion. See "Parameter Expansion"
#     and "Remove matching suffix pattern" in "man bash".
#
# The PBS_JOBID%.* parameter expansion:
# This removes the matching suffix pattern, in this case .* i.e. everyting after the PBS_JOBID.
# For instance if PBS_JOBID is 184327.hpcnode0 then PBS_JOBID%.* will be just 184327.
# Hence the scratch directory created will be /scratch/u999777_184327
# This will be unique for every PBS job you submit.

# Create a /scratch directory with a unique name.
SCRATCH="/scratch/${USER}_${PBS_JOBID%.*}"
mkdir ${SCRATCH}

# Change to the PBS working directory where qsub was started from.
# The shell parameter PBS_O_WORKDIR is the working directory where this job
# was started from. We do this because this bash script has started a new
# shell and so this point your working directory is your home directory.
cd ${PBS_O_WORKDIR}

# Copy your input files from there to the scratch directory you created above.
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
# Note we change out of the scratch directory before we try to remove it.
cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

