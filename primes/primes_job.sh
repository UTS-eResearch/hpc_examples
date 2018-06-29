#!/bin/bash

# Author: Mike Lake

# Important: 
# 1. In this example we have used a staff/student number of 999777
#    You will need to change all instances of this to your own staff/student 
#    number before you try and run this script. 
# 2. You will also need to set myjobdir to where ever you have placed 
#    this directory.
#
# Run this as qsub scriptname

##################
# Set PBS Commands 
# PBS commands must come at the top of this script, before any other commands.
#################

#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:10:00 
# There are several queues e.g. workq, smallq and others
#PBS -q smallq

# Send email on abort, begin and end. 
# CHANGE 999777 to your staff or student number!
#PBS -m abe 
#PBS -M 999777@uts.edu.au

###############
# Start the Job
###############

# Note: This simple example does not use any input files. 
# If you have large input files or large output files then create a scratch
# directory and copy your input files to there. 

# Screen output from the primes program will go to the PBS job output file, 
# e.g. run_job.sh.o685, and errors will go to the PBS error file e.g. run_job.sh.e686

# Change directory to where this script was submitted from. 
cd ${PBS_O_WORKDIR}

# Now run your program.
$myjobdir/primes.py

