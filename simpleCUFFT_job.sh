#!/bin/bash

# Run this as qsub scriptname

#PBS -l host=hpcinode1
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:5:00 
#PBS -q smallq
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

myjobdir=$HOME/src/cuda/

# This is required for a CUDA program.
source $myjobdir/set_cuda_env.sh

###################################
# Setup any input files for the run
###################################

#mkdir /scratch/work/mlake_$$
#cp input.dat /scratch/work/mlake_$$
#cd /scratch/work/mlake_$$

###############
# Start the Job
###############

$myjobdir/simpleCUFFT_UTS/simpleCUFFT

#########################################################
# Move/copy results back to your own directory and cleanup
#########################################################

#mv /scratch/work/mlake_$$/output.txt $myjobdir
#rmdir /scratch/work/mlake_$$

