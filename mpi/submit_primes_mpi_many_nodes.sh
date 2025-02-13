#!/bin/bash

# This will run the primes finding program across multiple nodes using multiple cores.

#PBS -N primes
#PBS -l walltime=00:10:00

# We will ask for a "chunk" of resources from a couple of nodes.
# The placement of the jobs on nodes will be "scatter" which means 
# that each "chunk" of resources is taken from a different host.
#PBS -l place=scatter

# This will run the primes finding program across 2 nodes using 8 cores total.
# We ask PBS for 2 chunks of resources (select=2) where each chunk provides
# 4 cores and we will run 4 MPI processes across those 4 cores on each chunk.
#PBS -l select=2:ncpus=4:mpiprocs=4:mem=5GB

module load openmpi-latest
cd $PBS_O_WORKDIR
cat $PBS_NODEFILE
mpiexec primes_mpi

