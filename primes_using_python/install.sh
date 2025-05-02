#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/primes_using_python/'
mkdir -p $dest

#pbs_script='primes_job.sh'

# Modify and copy the submission script.
#cat $pbs_script | sed 's/Mike.Lake@uts.edu.au/999777@uts.edu.au/' > temp
#cat temp | sed 's/\/shared\/homes\/mlake/$HOME/' > temp.sh

#cp temp.sh $dest/$pbs_script
#rm -f temp.sh
#rm -f temp

# Copy the remaining files.
cp README.txt $dest 
cp clean.sh $dest
cp submit_simple.sh $dest
cp submit_typical.sh $dest
cp primes.py $dest

#grep 'Mike.Lake@uts.edu.au' $pbs_script
#if [ $? -eq 0 ]; then
#    cat $pbs_script | sed 's/Mike.Lake@uts.edu.au/999777@uts.edu.au/' > temp.sh
#fi

