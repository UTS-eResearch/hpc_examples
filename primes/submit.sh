#!/bin/bash

# Example qsub submission script for the primes program.
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
# PBS commands must come at the top of this script, before any other commands.
#################

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 
# There are several queues e.g. workq, smallq and others
#PBS -q smallq
# Send email on abort, begin and end. 
# CHANGE 999777 to your staff or student number!
#PBS -m abe 
#PBS -M mike.lake@uts.edu.au

###################################
# Setup any input files for the run
###################################
  
# If you have any input files then create your own directory under the 
# "/scratch/work/" directory and copy your input files to there. 
# Note: This scratch directory will be on the node that the job has 
# been submitted to by PBS. 
SCRATCH="/scratch/work/${USER}_${PBS_JOBID%.*}"
mkdir ${SCRATCH}

# Change to the working directory where qsub was started from.
# Copy your input files from there to scratch.
cd ${PBS_O_WORKDIR}
if [ -f primes.txt ]; then 
    cp primes.txt ${SCRATCH}
fi

###############
# Start the Job
###############

# Change to the scratch directory where you copied your 
# input files to before you start. 
cd ${SCRATCH}
${PBS_O_WORKDIR}/primes_continuing.py

#####################################################
# Copy results back to your own directory and cleanup
#####################################################

# Move your data back to your own directory.
mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

# We don't want to have old directories hanging around
# so after copying your data back remove the directory. 
cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

