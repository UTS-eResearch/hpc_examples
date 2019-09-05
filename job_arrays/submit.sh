#!/bin/bash

# Example using PBS arrays to calulate prime numbers in batches. 

# Submit this script like these examples:
#
#   Submit with indices 1,2,3,4,5
#   qsub submit.sh -J 1-5
#
# or 
#
#   Submit with indices 1,3,5,7,9
#   qsub submit.sh -J 1-10:2
#
# Author: Mike Lake

# Note: The cpu, memory and time resources that you specify here 
# are for EACH individual array job, not all the jobs together.
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:15:00 
#PBS -N test

# Here we define the number of integers to check 
# within each individual array job. 
block_size=100000

# Calculate the integer we will start checking from; 
# e.g. if PBS_ARRAY_INDEX is 2 and block_size=100000 
# then this will be 2 * 100,000 = 200,000
start=$((PBS_ARRAY_INDEX * block_size))

# Calculate the integer we will end checking at; 
# e.g. if PBS_ARRAY_INDEX is 2 and block_size=100000 
# then this will be 2 * 100,000 -1 = 199,999
end=$((PBS_ARRAY_INDEX * block_size + block_size - 1))

# Now pass these start and end values to our primes program.
cd ${PBS_O_WORKDIR}
./primes.py $start $end > primes_${PBS_ARRAY_INDEX}.txt

