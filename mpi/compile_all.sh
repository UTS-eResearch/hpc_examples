#!/bin/bash

# This script will compile and build two Fortran primes programs.

# Load the latest OenMPI module.
module load openmpi-latest

# Compile using gfortran and output the executable primes_serial
gfortran primes_serial.f90 -o primes_serial

# Compile using gfortran but use the MPI wrapper output the executable primes_mpi
mpifort primes_mpi.f90 -o primes_mpi -lmpi

