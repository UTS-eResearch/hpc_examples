#!/bin/bash

# Installs all example files to the cluster.

dest="/shared/eresearch/pbs_job_examples"

echo ''
echo "=== Install All Examples to Cluster ==="
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
    echo "Are we on the cluster"
    exit 0
fi

cp README.yaml ${dest}/

for d in mpi primes ; do
    pushd $d
    ./install.sh
    popd
done

