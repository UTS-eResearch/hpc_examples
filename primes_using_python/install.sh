#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/primes_using_python/'
mkdir -p $dest

# Copy the files.
cp README.txt $dest 
cp clean.sh $dest
cp primes.py $dest
cp submit_simple.sh $dest
cp submit_typical.sh $dest


