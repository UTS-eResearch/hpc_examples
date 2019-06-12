#!/bin/bash

# Example of the simplest qsub submission script for the primes program.
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
# Set PBS Commands 
# PBS commands must come at the top of this script, before any other commands.
#################

# Set the resource requirements; 1 CPU, 5 GB memory and 5 minutes wall time.
#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 

# Send email on abort, begin and end. 
# CHANGE 999777 to your staff or student number!
#PBS -m abe 
#PBS -M 999777@uts.edu.au

# In this example there are no input files. 
# You just run the python program and your 
# output file will be in this directory.

./primes.py

