# MPI Examples README

MPI stands for "Message Passing Interface". MPI is used to send messages from
one process on a computer to another.

The MPI examples here are my own versions of various programs.

    clean.sh                  Remove PBS .o and .e output files.
    compile_all.sh            Compile all the programs.

    primes_serial.f90         FORTRAN program to calculate prime numbers, not using MPI.
    submit_primes_serial.sh   PBS submission script.

    primes_mpi.f90                     FORTRAN program to calculate prime numbers using MPI.
    submit_primes_mpi_many_nodes.sh    PBS submission script.
    submit_primes_mpi_single_node.sh   PBS submission script.

## Compiling & Running Serial Programs

Compile serial FORTRAN programs with gfortran:

    $ gfortran primes_serial.f90 -o primes_serial

You would just run it like this:

    $ ./primes_serial

But it should be run by submiting it as a PBS job:

    $ qsub submit_primes_serial.sh

## Compiling & Running MPI Programs

We need to load the MPI module before we compile or run an MPI program.
Loading this module changes login environment so that commands like 
mpif90 and mpiexec can be found.

    $ module load openmpi-latest

Now we can compile using the MPI FORTRAN parallel compiler:

    $ mpif90 primes_mpi.f90 -o primes_mpi -lmpi

To run an MPI program we then need to use "mpiexec" to run our program.
We can't just run it like this:

    $ ./primes_mpi
      Error: this requires an even number of processors.
      Also the number of processors must be evenly divisible into    100000000 .
      Try 4 or 8 etc.

When we use the mpiexec we can also specify how many cores will be used to run the program.

    $ mpiexec primes_mpi           <== This will default to using all the cores.
    $ mpiexec -np 4 ./primes_mpi   <== This will use 4 cores.
    $ mpiexec -np 8 ./primes_mpi   <== This will use 8 cores.

However they should be run within a PBS submission script!
There are two job submission script examples.

    $ qsub submit_primes_mpi_single_node.sh

and
 
    $ qsub submit_primes_mpi_many_nodes.sh

Read the section below and read the scripts to understand the difference between them.
You can also submit both jobs and use "qstat -an1" to see the difference when running.

    $ qstat -an1

If you log into one of those nodes you will see:

    hpcnode07 ~/$ ps -ax | grep primes
    677068   Rl   0:50 primes_mpi
    677069   Rl   0:50 primes_mpi
    677070   Rl   0:50 primes_mpi
    677071   Rl   0:50 primes_mpi

## Typical Results

The list of prime found will be in the file primes.dat

Find all primes up to 100,000,000

Using primes_serial takes about 1/2 a minute.

Using primes_mpi with the following MPI processes takes:

    PBS Select Statement   Time Taken
    --------------------   ----------
    ncpus=2:mpiprocs=2     26 seconds
    ncpus=4:mpiprocs=4     18 seconds
    ncpus=8:mpiprocs=8      9 seconds
    ncpus=16:mpiprocs=16    2 seconds

Also you will find that using two chunks of compute, each with 4 cores, 
takes about the same amount of time as one chunk using 8 cores.

    select=2:ncpus=4:mpiprocs=4  9 seconds

## MPI Job Placement on Nodes

You can specify how your job should be placed on nodes. 
You can choose to place each chunk on a different node,
or your job can use chunks that are all on one node. 

If you don't specify a placement then the default placement is "free" which
will place a chunk of a job on any free node. This is what you should normally use.

If you specify that the placement is to be "scatter" then only one chunk is
taken from any host.

    #PBS -l place=scatter

In this case you might have one chunk runnning on hpcnode03 and another 
chunk running on hpcnode04.

You will notice in the submission scripts that I have incuded a line:
"cat $PBS_NODEFILE". This can be useful but its use is not covered here.
You can leave out this line if you wish.

Reference: PBS Professional 2024.1 User's Guide, "4.7 Specifying Job Placement", 
page UG-66.

Mike Lake    
April 2025

