#!/bin/bash

# Install the example files.

dest="/shared/eresearch/pbs_job_examples/matlab/"
mkdir -p $dest

cp README.txt $dest
cp *.m $dest
cp clean.sh $dest
cp test_single_job.sh $dest
cp test_parallel_job.sh $dest

# Modify and copy the submission scripts.
#pbs_scripts=' test_single_job.sh test_parallel_job.sh girkos_job.sh'
#
#for pbs_script in $pbs_scripts; do
#    cat $pbs_script | sed 's/Mike.Lake@uts.edu.au/999777@uts.edu.au/' > $dest/$pbs_script
#done

