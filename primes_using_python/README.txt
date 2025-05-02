README
======

This directory contains a small python program to calculate prime numbers 
within a specified range. There are also two PBS job submission scripts to 
submit this primes program to the PBS scheduling system.

  clean.sh   - A simple example shell script to remove old files.
  primes.py  - A simple python 3 program to calculate primes. 
  primes.txt - Typical output from above program.

  submit_simple.sh  - A very simple example PBS submission script 
                      which does not use a "scratch" directory.
  submit_typical.sh - A more typical example PBS submission script 
                      which uses a local "scratch" directory.

Your programs should always use the /scratch directory for reading and 
writing large data files.

Installing these Examples
-------------------------

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cp -r /shared/eresearch/pbs_job_examples/primes jobs/
  $ cd jobs/primes

Read the program primes.py to understand what it does.
The programs comments will tell you aproximately how long it will take to find
the primes within a given range.
This program is also designed to pick up where it left off.
All of your programs should be able to do this. It's called checkpointing.

Running the Primes Program
--------------------------

Edit the submission scripts to include your own email in the script.

Now you can submit a PBS job to run your python script and find primes.

  $ qsub submit_simple.sh

or 

  $ qsub submit_typical.sh

You can follow the progress of your running job with qstat.

  $ qstat 

or 

  $ qstat -f job_id

Once the job has finished you can get full information, as in the qstat command above, 
by using -x for "expired" jobs.
  
  $ qstat -fx job_id

Once you understand what the submission scripts do you can write your 
own submission scripts based on these.

Remember: You should be using the /scratch directory for all large file reading and writing.

A Note on Output Buffering in Python
------------------------------------

Python by default will buffer its output when it is not being used in an
interactive environment. So if the program ends prematurely the full results
that have been calculated might not get written to the output file. We do not
want this behaviour. We want all results to be written immediately. 

To turn off output buffering you can add these two lines to the top of the program:

  import functools
  print = functools.partial(print, flush=True)

Or you can add this line to the PBS submission script just before you call your
python program:

  export PYTHONUNBUFFERED = 'True'

To see what happens if these lines are not added submit a job and, within a few seconds,
run "qdel job_id" to end the job. You will probably see that the jobs output file is 
empty. It would normally contain the output of the python program i.e.:

    Prime Number Finder
    Looking for prime numbers in the range 100000 to 200000 ...

Reference: "How to Flush the Output of the Python Print Function"
https://realpython.com/python-flush-print-output/

Mike Lake
April 2025

