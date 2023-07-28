#!/bin/bash

# This will run the primes finding program on one node using 8 cores.
# 
# Then we invoke mpiexec and specify -np 8

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l select=1:ncpus=8:mpiprocs=8:mem=5GB
#PBS -l walltime=00:10:00

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

module load openmpi-4.1.5
mpiexec -np 8 f_primes_mpi

