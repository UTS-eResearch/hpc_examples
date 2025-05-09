README
------

This describes how to checkpoint a program and to use a self submitting
script to run that program for longer than the maximum wall time allowed. 

The python program primes.py finds primes from 100,000 to 200,000, takes 
several minutes to run and finds 8392 primes. 

If you set a walltime of 1 minutes and submit normally:

    qsub sub_primes.sh
 
It ends at perhaps just a couple of thousand primes with:

    $ cat sub_primes.sh.e420678
    =>> PBS: job killed: walltime 71 exceeded limit 60
    $ 

and job information shows:
    
    $ qstat -fx 420678.hpcnode1
    
    PBS Job Id: 420678.hpcnode1
    Job Name:   sub_primes.sh
    Execution terminated
    Exit_status=271
    resources_used.cput=00:01:01
    resources_used.ncpus=1
    resources_used.walltime=00:01:11

We can submit this job with a more complex job submission script that will run beyond the 
normal wall time by resubmitting itself after the previous job submission has ended. It 
still relies on the program being able to checkpoint itself, picking up where it previously
left off. 

    qsub -v NJOBS=5 sub_primes_overtime.sh

This will run 5 jobs.

