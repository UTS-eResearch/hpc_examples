#!/bin/bash

# This will run the primes finding program across two nodes using 8 cores total.
# We ask PBS for 2 chunks of resources (select=2) where each chunk provides
# 4 cpus and mpiprocs=4
# Then we invoke mpiexec and specify -np 8

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l select=2:ncpus=4:mpiprocs=4:mem=5GB
#PBS -l walltime=00:10:00

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

module load openmpi-latest
mpiexec -np 8 primes_mpi

