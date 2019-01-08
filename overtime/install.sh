#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/overtime/'
mkdir -p $dest

# Update the date to todays date.
this_date=`date +'%Y.%m.%d'`
cat README.template | sed "s/THIS_DATE/$this_date/" > README.txt

# Modify and copy the submission scripts.
pbs_scripts='sub_primes.sh sub_primes_overtime.sh'
for pbs_script in $pbs_scripts; do
    cat $pbs_script | sed 's/Mike.Lake@uts.edu.au/999777@uts.edu.au/' > temp
    cat temp | sed 's/\/shared\/homes\/mlake/$HOME/' > temp.sh
    cp temp.sh $dest/$pbs_script
    rm -f temp.sh
    rm -f temp
done

# Copy the remaining files.
for f in README.txt clean.sh primes.py; do
    cp $f $dest
done

