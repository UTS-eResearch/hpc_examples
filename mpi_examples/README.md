# MPI Examples README

The MPI examples here are my own versions of various programs.

    clean.sh                  Remove PBS .o and .e output files.
    compile_all.sh            Compile all the programs.
    env.sh

    f_primes_serial.f90       FORTRAN program to calculate prime numbers, not using MPI.
    f_primes_serial_job.sh    PBS submission script.

    f_primes_mpi.f90     FORTRAN program to calculate prime numbers using MPI.
    f_primes_mpi_job.sh  PBS submission script.

    r_primes_mpi.r       R program to calculate prime numbers using MPI.
    r_primes_mpi_job.sh  PBS submission script.
    
    hello_mpi.c
    hello_mpi.sh

## Compiling & Running Serial Programs

Compile serial FORTRAN programs with `gfortran`:

    $ gfortran f_primes_serial.f90 -o f_primes_serial

Then just run it like so:

    $ ./f_primes_serial

Submit as a PBS job:

    $ qsub f_primes_serial_job.sh

# Compiling & Running MPI Programs

We need to load the MPI module before we compile or run an MPI program.
Loading this module changes login environment so that commands like 
mpif90 and mpiexec can be found.

    $ module load openmpi-4.0.4

Now we can compile using the MPI FORTRAN parallel compiler:

    $ mpif90 f_primes_mpi.f90 -o f_primes_mpi -lmpi

To run an MPI program we need to use `mpiexec`.

    $ mpiexec -np 4 ./f_primes_mpi

Submit as a PBS job:

    $ qsub f_primes_mpi_job.sh


Mike Lake    
September 2020

