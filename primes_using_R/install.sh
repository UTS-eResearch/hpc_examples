#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/primes_using_R/'
mkdir -p $dest

# Copy the files.
cp README.txt $dest 
cp clean.sh $dest
cp primes.r $dest
cp submit.sh $dest
