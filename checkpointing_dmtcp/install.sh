#!/bin/bash

# Installs these example files to the cluster's public area.

dest="/shared/eresearch/pbs_job_examples/checkpointing_dmtcp"

echo ''
echo "Install to $dest ?"
echo ''

echo '------ GIT Status ------'
git st

# Ask user what to do.
echo
echo 'Install these files?' 
echo "Press (y/Y) to delete or press any other key to exit."
read REPLY
if [ -z $REPLY ]; then
   exit 0
fi

# If user has NOT selected y/Y then exit.
if [ $REPLY != "y" ] && [ $REPLY != "Y" ]; then
    exit 0
fi

# Otherwise we continue.
if [ ! -d $dest ]; then
    echo "Error: Could not find $dest"
    echo "Are we on the cluster? Exiting."
    exit 0
fi

# Install 
cp README.txt $dest
cp primes.py  $dest
cp clean.sh   $dest
cp job_no_dmtcp.sh      $dest
cp job_launch_dmtcp.sh  $dest
cp job_restart_dmtcp.sh $dest
 
