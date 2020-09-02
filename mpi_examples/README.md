# MPI Examples README

The MPI examples here are my own versions of various programs.

    clean.sh
    compile_all.sh
    env.sh

    f_primes_serial.f90
    f_primes_serial_job.sh

    f_primes_with_mpi.f90
    f_primes_with_mpi_job.sh

    hello_mpi.c
    hello_mpi.sh

    r_primes_with_mpi_job.sh
    r_primes_with_mpi.r

## Compiling the Programs

    $ module load openmpi-4.0.4

Compile serial programs with: gfortran

Compile parallel programs with MPI like this:

    $ mpif90 hello_mpi.f90 -o hello_mpi -lmpi

## Running the Programs

    mpiexec -np 4 ./program


Mike Lake    
September 2020

