#!/bin/bash

#PBS -N primes
#PBS -m abe
#PBS -M Mike.Lake@uts.edu.au
#PBS -l walltime=00:10:00

## OPTION 1: MPI on a single node.
##           set -np 4
##PBS -l select=1:ncpus=4:mpiprocs=4:mem=5GB:centos6_node=no 
##PBS -l walltime=00:10:00

# OPTION 2
# set -np 8 
# e.g. exec_host = hpccnode03/2*4+hpccnode03/3*4
#      exec_vnode = (hpccnode03:ncpus=4:mem=5Gb)+(hpccnode03:ncpus=4:mem=5gb)
#PBS -l select=2:ncpus=4:mpiprocs=4:mem=5GB:centos6_node=no
#PBS -l walltime=00:10:00

###PBS -l select=2:ncpus=4:mpiprocs=128:mem=25GB
###PBS -l select=2:ncpus=4:mem=5GB:host=ermdc02 -l walltime=00:10:00

##PBS -l place=scatter:excl
#PBS -l place=scatter

module load openmpi-4.0.4

cd $PBS_O_WORKDIR
cat $PBS_NODEFILE

# OPTION 1
#mpiexec -np 4 f_primes_with_mpi

# OPTION 2
mpiexec -np 8 f_primes_with_mpi

## #source env.sh
#PATH=/opt/pbs/bin:$PATH
## export OMP_NUM_THREADS=1
## /usr/lib64/openmpi/bin/mpiexec --mca btl_base_warn_component_unused 0 --mca orte_base_help_aggregate 0 -np 4 mpi_prime


