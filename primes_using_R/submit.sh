#!/bin/bash

#PBS -N Test_R
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:10:00 
##PBS -q testq

# Send email on abort, begin and end.
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

# Change to the PBS working directory where qsub was started from.
cd ${PBS_O_WORKDIR}

# Run the primes program.
Rscript primes.r 100000 200000

