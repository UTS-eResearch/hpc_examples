README
------

This directory contains an example of how to use PBS job arrays. 

  primes.py  - A simple program to calculate primes. 
  submit.sh  - A simple example PBS submission script which uses job arrays.
  clean.sh   - A simple example shell script to remove old files.

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cd jobs
  jobs$ cp -r /shared/eresearch/pbs_job_examples/job_arrays .
  jobs$ cd job_arrays

Read the submit.sh script for how to submit an array job.

Mike Lake
September 2019

