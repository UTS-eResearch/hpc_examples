README
------

This directory contains a small python program to calculate prime numbers, 
modified so that it demonstrates how to profile a python program. 

  primes.py      - simple program to calculate primes 
  profile.dat    - example data from running 'python -m cProfile -o profile.dat primes.py'
  show_pstats.py - program to sort data from profile.dat

Copy this entire directory to your own directory to test this out.

  $ cp -r /shared/eresearch/pbs_job_examples/profiling .
  $ cd profilinga

You will also need to create a Python 3 virtual environment and install "pycallgraph2" 
using "pip install pycallgraph2". Then start this Python 3 virtual env.

Using pycallgraph

  $ pycallgraph graphviz -- ./primes.py

Using cProfile

  $ python3 -m cProfile -o profile.dat primes.py
  $ ./show_pstats.py

Also read https://hpc.research.uts.edu.au/software_general/python_profiling/

Mike Lake
September 2021

