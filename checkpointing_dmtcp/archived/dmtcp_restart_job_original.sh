#!/bin/bash

# This is the original example Mike Lake found at:
# https://github.com/rohgarg/dmtcp-job-scripts

# Standard PBS options and env. vars

#PBS -q QUEUE_NAME
#PBS -l ncpus=2

echo "PBS_JOBID="$PBS_JOBID
echo "PBS_NODEFILE"=$PBS_NODEFILE
echo "PBS_O_WORKDIR"=$PBS_O_WORKDIR

# DMTCP related env. vars.

export DMTCP_BASE=/path/to/dmtcp/root/dir
export DMTCP=$DMTCP_BASE/bin
export LD_LIBRARY_PATH=$DMTCP_BASE/lib/dmtcp:$LD_LIBRARY_PATH
export DMTCP_CHECKPOINT_DIR=$PBS_O_WORKDIR
#export DMTCP_TMPDIR=$PBS_O_WORKDIR/tmp
#export DMTCP_CHECKPOINT_INTERVAL=3
export DMTCP_GZIP=0 # NO GZIP
export PATH=$PATH:$DMTCP

cd $PBS_O_WORKDIR

# Function to start DMTCP coordinator
start_coordinator()
{
    # The following two steps can be easily automated, but we
    # are doing this manually here for debugging.

    # 1. Manually start the coordinator on some host ($DMTCP/dmtcp_coordinator)
    # 2. Change the following env. vars. accordingly
    export DMTCP_COORD_HOST=COORD_HOSTNAME
    export DMTCP_COORD_PORT=7779

}

#  Start DMTCP coordinator

start_coordinator

# Restart the program from its checkpoint images

$DMTCP/dmtcp_restart $DMTCP_CHECKPOINT_DIR/ckpt_*.dmtcp

