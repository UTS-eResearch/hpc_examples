#!/bin/bash

# Remove all files from run in prep for another run.
rm -f *.e*[0-9]
rm -f *.o*[0-9]
rm -f primes_[0-9]*.txt
rm -f progress.txt

# We also remove any file like this which would occur
# if there is no value for the $PBS_ARRAY_INDEX
rm -f primes_*.txt

