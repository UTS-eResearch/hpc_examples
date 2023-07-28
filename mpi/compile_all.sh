#!/bin/bash

module load openmpi-4.1.5

gfortran primes_serial.f90 -o primes_serial
mpif90 primes_mpi.f90 -o primes_mpi -lmpi

