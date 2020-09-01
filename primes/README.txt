README
------

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

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cp -r /shared/eresearch/pbs_job_examples/primes jobs/
  $ cd jobs/primes

Read what primes.py does. It's designed to pick up where it left off.
All of your programs should be able to do this. It's called checkpointing.
Finding primes from 100,000 to 300,000 should take about 3 minutes.

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

Mike Lake
August 2020

