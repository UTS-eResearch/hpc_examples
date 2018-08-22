README
------

This directory contains a small python program to calculate prime numbers, 
modified so that it demonstrates how to profile a python program. 

  primes.py      - simple program to calculate primes 
  profile.dat    - example data from running 'python -m cProfile -o profile.dat primes.py'
  show_pstats.py - program to sort data from profile.dat

Copy this entire directory to your own directory to test this out.

  $ cp -r /shared/eresearch/pbs_job_examples/profiling .
  $ cd profiling

Read https://hpc.research.uts.edu.au/software_general/python_profiling/

Mike Lake
August 2018

