#!/bin/bash

# This installs selected files from here to where users can read them.

dest='/shared/eresearch/pbs_job_examples/mpi/'
mkdir -p $dest

#pbs_script='primes_job.sh'
# Modify and copy the submission script.
#cat $pbs_script | sed 's/Mike.Lake@uts.edu.au/999777@uts.edu.au/' > temp
#cat temp | sed 's/\/shared\/homes\/mlake/$HOME/' > temp.sh
#cp temp.sh $dest/$pbs_script
#rm -f temp.sh
#rm -f temp

# Copy the README files.
cp README.md $dest 
cp README.yaml $dest 

# Copy the program files.
cp clean.sh $dest
cp compile_all.sh $dest
cp *.f90 $dest
cp submit_primes_serial.sh $dest
cp submit_primes_mpi_many_nodes.sh $dest
cp submit_primes_mpi_single_node.sh $dest

