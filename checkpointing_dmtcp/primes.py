#!/usr/bin/env python

# This program finds prime numbers. It was written as an example for 
# how to use the PBS job scheduler and how to write a program so that 
# it can pick up where it left off in case the program is terminated.
# 
# This program requires Python version 3.6 or later.
# 
# Input : None or a previous primes.txt file
# Output: primes.txt
#
# Author: Mike Lake

import os, time

# Define a starting integer and a larger ending integer as a range, 
# within which to test for prime numbers. A range of 100000 to 200000 
# will take about 3 to 4 minutes. 
start = 100000
end   = 200000

###########
# Functions
###########

def is_prime(n):
    '''
    Tests a number 'n' to see if it's a prime.
    Returns True if its a prime, False otherwise.
    '''
    primeness = False
    for x in range(2, n):
        if n % x == 0:
            # There is a factor so this number is not a prime.
            break
    else:
        # The loop completed without a break so there are
        # no factors found so this number is a prime.
        primeness = True

    return primeness

##########################
# Main program starts here
##########################

def main():

    global start, end

    print ('Prime Number Finder')
    print ('Looking for prime numbers in the range %d to %d ...' % (start, end))

    # Open the output file for writing.
    fh = open('primes.txt', 'w', 0) 
    fh.write('Prime numbers in the range %d--%d\n' % (start, end))
 
    # Finding new primes starts here.
    total_primes = 0
    for n in range(start, end):
        #print (n)
        #time.sleep(1)
        if is_prime(n):
            total_primes += 1
            fh.write('%s\n' % n)
            fh.flush()
    
    fh.close()
    print ('Found %d primes during this run.' % total_primes)

if __name__ == '__main__':
    main()

