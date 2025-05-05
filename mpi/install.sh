#!/bin/bash

# Installs selected files from here to where users can read them.

dest='/shared/eresearch/pbs_job_examples/mpi/'
mkdir -p $dest

cp README.yaml $dest 
cp README.md $dest 
cp clean.sh $dest
cp compile_all.sh $dest
cp *.f90 $dest
cp submit_primes_serial.sh $dest
cp submit_primes_mpi_many_nodes.sh $dest
cp submit_primes_mpi_single_node.sh $dest

