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

# Note: The cuda directory in here is just for Mikes testing at this stage
# so its not copied up to destination.

for d in checkpointing_dmtcp job_arrays matlab mpi overtime \
      primes_using_python primes_using_r \
      profiling ; do
    echo "${d} "
    pushd $d > /dev/null
    ./install.sh
    popd >/dev/null
done

