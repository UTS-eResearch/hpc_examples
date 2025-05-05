#!/bin/bash

# Installs these example files to the cluster's public area.

dest='/shared/eresearch/pbs_job_examples/job_arrays/'
mkdir -p $dest

cp README.txt $dest
cp clean.sh $dest
cp primes.py $dest
cp submit.sh $dest


