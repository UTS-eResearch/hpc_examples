#!/bin/bash

# Restart a DMTCP job.

#PBS -N test
#PBS -l ncpus=1
#PBS -l mem=5GB
#PBS -l walltime=00:05:00 
#PBS -q smallq
#PBS -m abe 
#PBS -M Mike.Lake@uts.edu.au

# DMTCP related env. vars.
export DMTCP=/usr/bin
export DMTCP_CHECKPOINT_DIR=$PBS_O_WORKDIR
#export DMTCP_TMPDIR=$PBS_O_WORKDIR
#export DMTCP_CHECKPOINT_INTERVAL=3
export DMTCP_GZIP=0 # NO GZIP
export LD_LIBRARY_PATH=/usr/lib64/dmtcp:$LD_LIBRARY_PATH

cd $PBS_O_WORKDIR

# Function to start DMTCP coordinator
start_coordinator()
{
    # The following two steps can be easily automated, but we
    # are doing this manually here for debugging.
    # 1. Manually start the coordinator on some host ($DMTCP/dmtcp_coordinator)
    # 2. Change the following env. vars. accordingly
    export DMTCP_COORD_HOST=localhost
    export DMTCP_COORD_PORT=7779
}

#  Start DMTCP coordinator
start_coordinator

SCRATCH="/scratch/work/${USER}_108870"
mkdir ${SCRATCH}
mv primes.txt ${SCRATCH}

# Restart the program from its checkpoint images
dmtcp_restart $DMTCP_CHECKPOINT_DIR/ckpt_*.dmtcp

mv ${SCRATCH}/primes.txt ${PBS_O_WORKDIR}

cd ${PBS_O_WORKDIR}
rmdir ${SCRATCH}

