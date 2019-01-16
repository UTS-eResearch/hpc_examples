#!/bin/bash

# Launch a DMTCP job.

#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 

# DMTCP related environment variables.
# The checkpointing interval is in seconds. 
export DMTCP_CHECKPOINT_DIR=$PBS_O_WORKDIR
export DMTCP_TMPDIR=$PBS_O_WORKDIR
export DMTCP_CHECKPOINT_INTERVAL=30
export DMTCP_GZIP=0  # No GZIP compression
export LD_LIBRARY_PATH=/usr/lib64/dmtcp:$LD_LIBRARY_PATH

# Function to start the DMTCP coordinator
start_coordinator()
{
    # For a more complete example see: 
    # https://github.com/dmtcp/dmtcp/blob/master/plugin/batch-queue/job_examples/slurm_launch.job
    # Manually start the coordinator on localhost.
    export DMTCP_COORD_HOST=localhost
    export DMTCP_COORD_PORT=7779     # default is 7779
}

SCRATCH="/scratch/work/${USER}_${PBS_JOBID%.*}"
mkdir ${SCRATCH}

#  Start DMTCP coordinator
start_coordinator

# Launch the program
cd ${SCRATCH}
dmtcp_launch ${PBS_O_WORKDIR}/primes.py

# Move your data back to the submission directory.
mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

# Remove the scratch directory.
cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

