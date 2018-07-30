README
------

This directory contains a small python program to calculate prime numbers within a specified range.
There is also a PBS job submission script to submit this primes program to the PBS scheduling system.

  clean.sh      - simple example shell script to remove old files.
  primes.py     - simple program to calculate primes 
  primes.txt    - typical output from above program
  primes_job.sh - example PBS shell script 
  primes_job_advanced.sh - example shell script with more optional features.

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cd jobs
  jobs/$ cp -r /shared/eresearch/primes .
  primes/$ cd primes

Usage: 

  $ qsub primes_job.sh

or 

  $ qsub primes_job_advanced.sh 

Mike Lake
September 2017
