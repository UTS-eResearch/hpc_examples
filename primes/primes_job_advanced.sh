#!/bin/bash

# Author: Mike Lake

# Important: 
# 1. In this example we have used a staff/student number of 999777
#    You will need to change all instances of this to your own staff/student 
#    number before you try and run this script. 
# 2. You will also need to set myjobdir to where ever you have placed 
#    this directory.
#
# Run this as qsub [options] scriptname

##################
# Set PBS Commands 
# PBS commands must come at the top of this script, before any other commands.
#################

#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:2:00 
#PBS -q smallq

# Send email on abort, begin and end.
#PBS -m abe 
#PBS -M 999777@uts.edu.au

###############################
# Define a few useful variables
###############################

# This is where all your job files for this particular job are located. 
myjobdir=$HOME/jobs/primes

###################################
# Setup any input files for the run
###################################
  
# If you have any input files then create a scratch directory and copy your
# input files to there. 
# Note: This scratch directory will be on the node that the job has been 
# submitted to by PBS so you may not see it on the head node's /scratch directory. 
mkdir /scratch/work/999777_$$

# This is commented out as we don't have any input files. 
# cp input.dat /scratch/work/999777_$$

# If you have input files then you must change directory to where these working
# files are located before you start. 
cd /scratch/work/999777_$$

###############
# Start the Job
###############

# Screen output from the primes program will go to the PBS job output file, 
# e.g. run_job.sh.o685, and errors will go to the PBS error file e.g. run_job.sh.e686

$myjobdir/primes.py

##########################
# Copy results back to your own directory and cleanup
##########################

# Move your data back to your own directory.
mv /scratch/work/999777_$$/primes.txt $myjobdir

# We don't want to have old directories hanging around so after copying your 
# data back remove the directory. 
rmdir /scratch/work/999777_$$

