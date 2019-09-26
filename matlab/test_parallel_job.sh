#!/bin/bash

#PBS -N TestMatlab
#PBS -l ncpus=5
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 

module load matlab-2017b
cd ${PBS_O_WORKDIR}

OPTS='-nodisplay -nosplash -nodesktop -singleCompThread' 
matlab $OPTS < test_parallel.m

