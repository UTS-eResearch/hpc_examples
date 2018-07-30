#!/bin/bash

# Author: Mike Lake

# Important: 
# In this example we have used a staff/student number of 999777.
# You will need to change all instances of this to your own 
# staff/student number before you try and run this script. 
#
# Run this as qsub scriptname

##################
# Set PBS Commands 
# PBS commands must come at the top of this script, before any other commands.
#################

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 
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

# The following assumes that the program primes.py is in the same directory 
# as this script. We change directory to this directory.
cd ${PBS_O_WORKDIR}

# Now run your program.
./primes.py

