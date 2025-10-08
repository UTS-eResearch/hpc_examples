#!/bin/bash

# Remove all primes output and PBS output and error files.

rm -f *.e[0-9]*
rm -f *.o[0-9]*
rm -f primes.txt
rm -f primes_mpi
rm -f primes_serial

