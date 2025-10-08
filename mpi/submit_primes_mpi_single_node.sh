#!/bin/bash

# This will run the primes finding program on one node using 4 cores.
# i.e. we will run 4 MPI processes across those 4 cores.

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l select=1:ncpus=4:mpiprocs=4:mem=5GB
#PBS -l walltime=00:10:00

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

module load openmpi-latest
mpiexec primes_mpi

