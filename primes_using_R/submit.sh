#!/bin/bash

# Run this as: qsub submit.sh
#
# Author: Mike Lake

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
#PBS -N primes
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00

# Send email on abort, begin and end.
# CHANGE the below to your email and remove the extra # from the start of the next two lines.
##PBS -m abe
##PBS -M Your.Email@uts.edu.au

# In this example there are no input files.
# You just change directory to where your program is and run it.
# Your output file will be in that directory.
# The shell parameter PBS_O_WORKDIR is the working directory where this job was started from.

cd ${PBS_O_WORKDIR}
Rscript primes.r 100000 200000

