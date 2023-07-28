#!/bin/bash

# This will run the primes finding program across two nodes using 8 cores total.
# We ask PBS for 2 chunks of resources (select=2) where each chunk provides
# 4 cpus  mpiprocs=4

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l select=2:ncpus=4:mpiprocs=4:mem=5GB
#PBS -l walltime=00:10:00

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

module load openmpi-4.1.5
mpiexec -np 8 primes_mpi

