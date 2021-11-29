README
------

Any significant matlab work must be run under PBS.

This directory contains examples of PBS scripts for using Matlab.
Copy this entire directory to your own directory to test these out.

  test_single_job.sh    Running a single thread on one core only.
  test_single.m         "

  test_parallel_job.sh  Running in parallel on multiple cores.
  test_parallel.m       "

  clean.sh              Remove all files from run in prep for another run.

Usage: 

  $ qsub test_single_job.sh

Mike Lake
eResearch

