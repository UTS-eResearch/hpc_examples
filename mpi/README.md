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

## Compiling & Running MPI Programs

We need to load the MPI module before we compile or run an MPI program.
Loading this module changes login environment so that commands like 
mpif90 and mpiexec can be found.

    $ module load openmpi-latest

Now we can compile using the MPI FORTRAN parallel compiler:

    $ mpif90 f_primes_mpi.f90 -o f_primes_mpi -lmpi

To run an MPI program we need to use `mpiexec`.

    $ mpiexec -np 4 ./f_primes_mpi

Submit as a PBS job:

    $ qsub f_primes_mpi_job.sh

## MPI Job Placement on Nodes

You can specify how your job should be placed on nodes. 
You can choose to place each chunk on a different node,
or your job can use chunks that are all on one node. 

If you don't specify a placement then the default placement is "free" which
will place a chunk of a job on any free node.

If you specify that the placement is to be "scatter" then only one chunk is
taken from any host.

    #PBS -l place=scatter

In this case you might have one chunk runnning on hpcnode03i and another 
chunk running on hpcnode04.

Reference: PBS Professional 2021.1 User's Guide, "4.7 Specifying Job Placement", 
page UG-64.

Mike Lake    
July 2023

