#!/bin/bash

# Example qsub submission script for the primes program,
# but restarting under DMTCP from the last checkpoint.
# Run this as qsub scriptname
#
# Author: Mike Lake

#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00

# DMTCP related environment variables.
# The checkpointing interval is in seconds.
export DMTCP_CHECKPOINT_INTERVAL=30
export DMTCP_CHECKPOINT_DIR=$PBS_O_WORKDIR
export DMTCP_TMPDIR=$PBS_O_WORKDIR
export DMTCP_GZIP=0  # No GZIP compression
export LD_LIBRARY_PATH=/usr/lib64/dmtcp:$LD_LIBRARY_PATH

# Function to start the DMTCP coordinator
start_coordinator()
{
    export DMTCP_COORD_HOST=localhost
    export DMTCP_COORD_PORT=7779     # default is 7779
}

#  Start DMTCP coordinator
start_coordinator

# We have to create the same name scratch directory as before and restore
# the previously checkpointed data back to there.
SCRATCH="/scratch/${USER}_108870"
mkdir ${SCRATCH}
mv primes.txt ${SCRATCH}

# Restart the program from its checkpoint images.
# Note we stay in the directory where the checkpoint images are,
# not the scratch directory.
cd $PBS_O_WORKDIR
dmtcp_restart $DMTCP_CHECKPOINT_DIR/ckpt_*.dmtcp

# Move your output data back to the submission directory.
mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

# Remove the scratch directory.
cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

