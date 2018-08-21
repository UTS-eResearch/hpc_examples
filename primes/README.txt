README
------

This directory contains a small python program to calculate prime numbers 
within a specified range. There is also a PBS job submission script to 
submit this primes program to the PBS scheduling system.

  clean.sh    - simple example shell script to remove old files
  primes.py   - simple program to calculate primes 
  primes.txt  - typical output from above program
  submit.sh   - example PBS submission script 

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cd jobs
  jobs$ cp -r /shared/eresearch/pbs_job_examples/primes .
  jobs$ cd primes

Read what primes.py does.

Edit submit.sh to include your own email in the script.

Now you can submit a PBS job to run your python script and find primes.

  $ qsub submit.sh

Mike Lake
August 2018

