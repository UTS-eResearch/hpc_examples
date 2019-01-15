#!/bin/bash

# Example qsub submission script for the primes program.
# Run this as qsub scriptname
#
# Author: Mike Lake

#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 

# Create a scratch directory for the output.
SCRATCH="/scratch/work/${USER}_${PBS_JOBID%.*}"
mkdir ${SCRATCH}

# Change to the scratch directory and start the job.
cd ${SCRATCH}
${PBS_O_WORKDIR}/primes.py

# Move your output data back to the submission directory.
mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

# We don't want to have old directories hanging around
# so after copying your data back remove the directory. 
cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

