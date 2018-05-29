#!/bin/bash

# This is a simple PBS script that uses the "interactive" mode of PBS
# to just provide shell access to the head GPU node of the cluster 
# See "Interactive-batch Jobs" in the "PBS User Guide".
#
# For interactive use you must submit this job with -I 
#
#   qsub -I gpu_access.sh
#

# maximums: ncps=48, walltime=200:00:00, mem=256GB/48cores
# but for interactive use we use the minimums.
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -q smallq

# Set your interactive wall time limit.
#PBS -l walltime=00:01:00

# Set your email.
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

# Set the node to start an interactive session on.
#PBS -l host=ermdc21

# Note: all other commands won't work.

