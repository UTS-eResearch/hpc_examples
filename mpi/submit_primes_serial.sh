#!/bin/bash

#PBS -N primes
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:10:00

##PBS -m abe 
##PBS -M Your.Email@uts.edu.au

cd $PBS_O_WORKDIR
./primes_serial

