#!/bin/bash

# Just check diffs of the installed files to the originals.

installed="/shared/eresearch/pbs_job_examples/mpi"
echo "These files differ from the installed versions at $installed"
for f in $installed/*; do
    diff $f ${f##*/} > /dev/null
    if [ $? -ne 0 ]; then
        # Files differ
        echo -e "\n========= $f ========="
        # We just use sed to indent the diff a bit.
        diff $f ${f##*/} | sed 's/^/  /'
    fi
done

# Not using the below.
# Check fortran and shell scripts. 
# shopt -s extglob
#for f in $installed/?(*.sh|*.f90); do
    #if [ "./$f" == $0 ]; then
    #    # But skip this script.
    #    echo "skipping $f"
    #    continue
    #fi
#done

