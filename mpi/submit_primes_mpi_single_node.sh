#!/bin/bash

# This will run the primes finding program on one node using 8 cores.
# We will run 8 MPI processes across those 8 cores.

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l select=1:ncpus=8:mpiprocs=8:mem=5GB
#PBS -l walltime=00:10:00

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

module load openmpi-latest
mpiexec primes_mpi

