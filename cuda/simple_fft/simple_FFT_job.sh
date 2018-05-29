#!/bin/bash

# Run this as qsub scriptname

#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:5:00 
#PBS -q smallq
#PBS -l host=ermdc23

#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

cd ${PBS_O_WORKDIR}
source ../set_cuda_env.sh
./simple_FFT

