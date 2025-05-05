#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/profiling/'
mkdir -p $dest

# Copy the files.
cp README.txt $dest 
cp primes.py  $dest
cp show_pstats.py $dest

