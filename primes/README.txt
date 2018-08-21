README
------

This directory contains a small python program to calculate prime numbers 
within a specified range. There is also a PBS job submission script to 
submit this primes program to the PBS scheduling system.

  clean.sh     - simple example shell script to remove old files
  primes_26.py - simple program to calculate primes for Python 2.6 or 2.7
  primes_36.py - simple program to calculate primes for Python 3.6 or later
  primes.txt   - typical output from above program
  submit.sh    - example PBS submission script 

Copy this entire directory to your own directory to test this out.

  $ cd
  $ mkdir jobs
  $ cd jobs
  jobs$ cp -r /shared/eresearch/pbs_job_examples/primes .
  jobs$ cd primes

Then copy either primes_26.py or primes_36.py to primes.py.
You can check what version of Python your using with "python --version".

Now you can submit a PBS job to run your python script and find primes.

  $ qsub submit.sh

Mike Lake
August 2018

