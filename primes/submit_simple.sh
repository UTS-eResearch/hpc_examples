#!/bin/bash

# Example of the simplest qsub submission script for the primes program.
# Please read submit_advanced.sh which is more typical of what your 
# submission script should be like.
#
# Important: 
#   In this example we have used a staff/student number of 999777.
#   You will need to change all instances of this to your own 
#   staff/student number before you try and run this script. 
#   See the "PBS -M" below.
#
# Run this as qsub scriptname
#
# Author: Mike Lake

##################
# PBS commands must come at the top of this script, 
# before any other commands.
#################

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 

# Send email on abort, begin and end. 
# CHANGE 999777 to your staff or student number!
#PBS -m abe 
##PBS -M 999777@uts.edu.au
#PBS -M mike.lake@uts.edu.au

# In this example there are no input files. 
# You just change directory to where your program is and run it. 
# Your output file will be in that directory.
# The shell parameter PBS_O_WORKDIR is the working directory where this job was started from.

cd ${PBS_O_WORKDIR}
./primes.py

