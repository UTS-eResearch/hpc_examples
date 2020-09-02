#!/bin/bash

# maximums: ncps=48, walltime=200:00:00, mem=256GB/48cores

#PBS -N primes_1
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:60:00
#PBS -l host=ermdc02 

##PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

cd $PBS_O_WORKDIR
./serial_prime

