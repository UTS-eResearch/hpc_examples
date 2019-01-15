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
# Checkpointing interval (in seconds). To manually trigger a checkpoint, use:
#   dmtcp_command --checkpoint --coord-host <COORD_HOSTNAME>  <COORD_PORT>
# OR
#   Go to the coordinator terminal and enter 'c'
#     $ dmtcp_coordinator 
#     dmtcp_coordinator starting...
#         Host: hostname (p.q.r.s)
#         Port: 7779
#         Checkpoint Interval: disabled (checkpoint manually instead)
#         Exit on last client: 0
#     c
export DMTCP_CHECKPOINT_INTERVAL=5
export DMTCP_GZIP=0 # NO GZIP compression
export PATH=$PATH:$DMTCP

cd $PBS_O_WORKDIR

# Function to start DMTCP coordinator
start_coordinator()
{
    # The following two steps can be easily automated, but we
    # are doing this manually here for debugging. For another
    # example, see: https://github.com/dmtcp/dmtcp/blob/master/plugin/batch-queue/job_examples/slurm_launch.job

    # 1. Manually start the coordinator on some host ($DMTCP/dmtcp_coordinator)
    # 2. Change the following env. vars. accordingly
    export DMTCP_COORD_HOST=COORD_HOSTNAME
    export DMTCP_COORD_PORT=COORD_PORT

}

#  Start DMTCP coordinator

start_coordinator

# Launch the program

# For a regular non-MPI program
$DMTCP/dmtcp_launch --dmtcp-options /path/to/program --program-options

# For an MPI program, do:
# $DMTCP/dmtcp_launch mpiexec /path/to/program
# OR
# $DMTCP/dmtcp_launch mpirun /path/to/program

