#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/job_arrays/'
mkdir -p $dest

cp README.txt $dest 
cp clean.sh $dest
cp submit.sh $dest
cp primes.py $dest

