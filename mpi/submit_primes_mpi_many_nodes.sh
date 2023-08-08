#!/bin/bash

# This will run the primes finding program across two nodes using 8 cores total.
# We ask PBS for 2 chunks of resources (select=2) where each chunk provides
# 4 cpus and we will run 4 MPI processes across those 4 cores on each chunk.

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l select=2:ncpus=8:mpiprocs=8:mem=5GB
#PBS -l walltime=00:10:00

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

module load openmpi-latest
mpiexec primes_mpi

