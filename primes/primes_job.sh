#!/bin/bash

# Author: Mike Lake

# Important: 
# 1. In this example we have used a staff/student number of 999777
#    You will need to change all instances of this to your own staff/student 
#    number before you try and run this script. 
# 2. You will also need to set myjobdir to where ever you have placed 
#    this directory.

# Run this as qsub scriptname

##################
# Set PBS Commands 
# PBS commands must come at the top of this script, before any other commands.
# maximums: ncps=48, walltime=200:00:00, mem=256GB/48cores
#################

#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=10:10:00 
# There are several queues e.g. workq, smallq and others
#   workq is the default, limited to 2 jobs at once and
#   smallq allows up to 8 jobs at once if you use less than 2 cores.
#PBS -q smallq
###PBS -l host=ermdc15

# Send email on abort, begin and end. 
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au


###############
# Start the Job
###############

# Note: This simple example does not use any input files. 
# If you have large input files or large output files then create a scratch
# directory and copy your input files to there. 

# Screen output from the primes program will go to the PBS job output file, 
# e.g. run_job.sh.o685, and errors will go to the PBS error file e.g.
# run_job.sh.e686

# This is an example of setting a variable which specifies where your program or data is located.
myjobdir=$HOME/jobs/primes

# Now change to this directory and run your program.
cd $myjobdir
$myjobdir/primes.py

