#!/bin/bash

# Launch a DMTCP job.

#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 
#PBS -q smallq
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

# DMTCP related env. vars.
# Checkpointing interval (in seconds). To manually trigger a checkpoint, use:
#   dmtcp_command --checkpoint --coord-host <COORD_HOSTNAME>  <COORD_PORT>
# or
#   Go to the coordinator terminal and enter 'c'
#     $ dmtcp_coordinator 
#     dmtcp_coordinator starting...
#         Host: hostname (p.q.r.s)
#         Port: 7779
#         Checkpoint Interval: disabled (checkpoint manually instead)
#         Exit on last client: 0
export DMTCP_CHECKPOINT_DIR=$PBS_O_WORKDIR
export DMTCP_CHECKPOINT_INTERVAL=30
export DMTCP_GZIP=0 # NO GZIP compression
export LD_LIBRARY_PATH=/usr/lib64/dmtcp:$LD_LIBRARY_PATH

# Function to start DMTCP coordinator
start_coordinator()
{
    # The following two steps can be easily automated, but we are doing this
    # manually here for debugging. For another example, see: 
    # https://github.com/dmtcp/dmtcp/blob/master/plugin/batch-queue/job_examples/slurm_launch.job
    # 1. Manually start the coordinator on some host ($DMTCP/dmtcp_coordinator)
    # 2. Change the following env. vars. accordingly
    export DMTCP_COORD_HOST=localhost
    export DMTCP_COORD_PORT=7779     # default is 7779
}

SCRATCH="/scratch/work/${USER}_${PBS_JOBID%.*}"
mkdir ${SCRATCH}
cd ${SCRATCH}

#  Start DMTCP coordinator
start_coordinator

# Launch the program
dmtcp_launch ${PBS_O_WORKDIR}/primes.py

# Move your data back to your own directory.
mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

