#!/bin/bash

#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:11:00 
#PBS -q smallq
###PBS -l host=
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

###PBS -c c=2

myjobdir=$HOME/jobs/checkpoint
cd $myjobdir
echo "Doing JOBID=$PBS_JOBID JOBNAME=$PBS_JOBNAME"
$myjobdir/primes.py

