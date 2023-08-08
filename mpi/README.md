# MPI Examples README

The MPI examples here are my own versions of various programs.

    clean.sh                  Remove PBS .o and .e output files.
    compile_all.sh            Compile all the programs.

    submit_python_version.sh  Just gets the Python version number using MPI.

    primes_serial.f90         FORTRAN program to calculate prime numbers, not using MPI.
    submit_primes_serial.sh   PBS submission script.

    primes_mpi.f90                     FORTRAN program to calculate prime numbers using MPI.
    submit_primes_mpi_many_nodes.sh    PBS submission script.
    submit_primes_mpi_single_node.sh   PBS submission script.

## Compiling & Running Serial Programs

Compile serial FORTRAN programs with `gfortran`:

    $ gfortran primes_serial.f90 -o primes_serial

Then just run it like so:

    $ ./primes_serial

Submit as a PBS job:

    $ qsub submit_primes_serial.sh

## Compiling & Running MPI Programs

We need to load the MPI module before we compile or run an MPI program.
Loading this module changes login environment so that commands like 
mpif90 and mpiexec can be found.

    $ module load openmpi-latest

Now we can compile using the MPI FORTRAN parallel compiler:

    $ mpif90 primes_mpi.f90 -o primes_mpi -lmpi

To run an MPI program we need to use `mpiexec`.

    $ mpiexec -np 4 ./primes_mpi

Submit as a PBS job. There are two job submission script examples.

    $ qsub submit_primes_mpi_single_node.sh

and
 
    $ qsub submit_primes_mpi_many_nodes.sh

Read the section below and read the scripts to understand the difference between them.
You can also submit both jobs and use `qstat -an1` to see the difference when running.

    $ qstat -an1

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

You will notice in the submission scripts that I have incuded a line:
`cat $PBS_NODEFILE`. This can be useful but its use is not covered here.
You can leave out this line if you wish.

Reference: PBS Professional 2021.1 User's Guide, "4.7 Specifying Job Placement", 
page UG-64.

Mike Lake    
July 2023

