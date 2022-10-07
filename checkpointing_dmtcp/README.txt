README
------

This is the directory /shared/eresearch/pbs_job_examples/checkpointing_dmtcp
In here are scripts to demonstrate how to use DMTCP: Distributed Multi Threaded Check Pointing.

File                    Description
----                    -----------

primes.py               Program to find primes, adapted to include time information.
primes.txt              Output created by primes.py

job_no_dmtcp.sh         Submit job without using DMTCP.
job_launch_dmtcp.sh     Submit job using DMTCP to checkpoint running primes.py.
job_restart_dmtcp.sh    Submit job to restart a job using DMTCP.

clean.sh                Script to clean out old test runs.

When these scripts are run additional files will be created:

test.e108869            PBS standard error file.
test.o108869            PBS stdout file.

ckpt_python_*.dmtcp         DMTCP created checkpoint image.
dmtcp_restart_script_*.sh   DMTCP created script to restart using this image.
dmtcp_restart_script.sh     DMTCP created symlink to the latest restart script.

