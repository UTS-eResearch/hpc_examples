#!/bin/bash

# This will run the primes finding program across multiple nodes using multiple cores.

#PBS -N primes
#PBS -l walltime=00:10:00
#PBS -l place=scatter
##PBS -q testq

#################################################
# Uncomment this for testing MPI compiled for PBS
#################################################

# This will run the primes finding program across 2 nodes using 8 cores total.
# We ask PBS for 2 chunks of resources (select=2) where each chunk provides
# 4 cores and we will run 4 MPI processes across those 4 cores on each chunk.
##PBS -l select=2:ncpus=4:mpiprocs=4:mem=5GB

#PBS -l select=1:ncpus=4:mpiprocs=4:mem=5GB:host=hpcnode04+1:ncpus=4:mpiprocs=4:mem=5GB:host=hpcnode07

module load openmpi-latest
cd $PBS_O_WORKDIR
cat $PBS_NODEFILE
mpiexec primes_mpi

############################################
# Uncomment this for testing OS Packaged MPI
############################################

# Installed via dnf the openmpi package on just hpcnode03 and hpcnode04
##PBS -l select=1:ncpus=8:mpiprocs=8:host=hpcnode03+1:ncpus=8:mpiprocs=8:host=hpcnode04
#cd $PBS_O_WORKDIR
#cat $PBS_NODEFILE
#/usr/lib64/openmpi/bin/mpiexec -np 8 primes_mpi

# end

# This uses an mpiexec that is provided by PBSPro.
# DO NOT USE THIS.
#/opt/pbs/bin/mpiexec primes_mpi
#  hpcnode01 mpi/$ cat primes.e723308
#  mpiexec:  unexpected error - no non-PBS mpiexec in PBS_O_PATH

