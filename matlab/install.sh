#!/bin/bash

# Installs these example files to the cluster's public area.

dest='/shared/eresearch/pbs_job_examples/matlab/'
mkdir -p $dest

cp README.txt $dest
cp clean.sh $dest
cp *.m $dest
cp test_single_job.sh $dest
cp test_parallel_job.sh $dest

