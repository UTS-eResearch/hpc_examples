README
------

This directory contains a small python program to calculate prime numbers 
within a specified range. There is also a PBS job submission script to 
submit this primes program to the PBS scheduling system.

  clean.sh   - A simple example shell script to remove old files.
  primes.py  - A simple program to calculate primes. 
  primes.txt - Typical output from above program.

  submit_simple.sh   - A very simple example PBS submission script 
                       which does not use a "scratch" directory.
  submit_advanced.sh - A more typical example PBS submission script 
                       which uses a local "scratch" directory.

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cd jobs
  jobs$ cp -r /shared/eresearch/pbs_job_examples/primes .
  jobs$ cd primes

Read what primes.py does. It's designed to pick up where it left off.

Edit the submission scripts to include your own email in the script.

Now you can submit a PBS job to run your python script and find primes.

  $ qsub submit_simple.sh

or 

  $ qsub submit_advanced.sh

Once you understand what the submission scripts do you can write your 
own submission scripts based on these.

Mike Lake
June 2019

