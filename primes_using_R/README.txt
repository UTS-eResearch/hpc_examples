README
=====

This directory contains a small R program to calculate prime numbers 
within a specified range. There is also a PBS job submission script
to submit this primes program to the PBS scheduling system.

  clean.sh   - A simple example shell script to remove old files.
  primes.r   - A simple R program to calculate primes. 
  primes.txt - Typical output from above program.
  primes.log - Shows progress of the program as it runs.
  submit.sh  - A very simple example PBS submission script. 

Installing these Examples
-------------------------

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cp -r /shared/eresearch/pbs_job_examples/primes_using_R jobs/
  $ cd jobs/primes_using_R

