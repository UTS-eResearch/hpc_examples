#!/bin/bash

# Installs these example files to the cluster's public area.

dest='/shared/eresearch/pbs_job_examples/checkpointing_dmtcp'

cp README.txt $dest
cp clean.sh $dest
cp primes.py $dest
cp job_no_dmtcp.sh $dest
cp job_launch_dmtcp.sh  $dest
cp job_restart_dmtcp.sh $dest

