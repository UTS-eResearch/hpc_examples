#!/usr/bin/env python

# This program finds prime numbers. 
# This is written as an example for how to use the Python Profiler 
# which can show you how much time is spent in each part of your program.
#
# Input : None 
# Output: primes.txt
#
# Author: Mike Lake

# For how to profile this program read the README.txt file. 
from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput
# To use the pycallgraph module invoke it like this:  
# with PyCallGraph(output=GraphvizOutput()):
#     do code

import os, sys, time

# Define a starting integer and a larger ending integer as a range, 
# within which to test for prime numbers. 
start = 10000
end   = 20000

###########
# Functions
###########

def timeme(start_time, comment=''):
    '''
    This is a simplistic way to time your program.
    Print the time between a start_time, passed in as the first arg, 
    and the current time.
    '''
    now = time.time()
    print ('TIME %.3f seconds, ' % (now-start_time), '%s' % comment)

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

    start_time = time.time()
    print ('Prime Number Finder')
    print ('Looking for prime numbers in the range %d to %d ...' % (start, end))
    
    # Open the output file for writing.
    fh = open('primes.txt', 'w') 
    fh.write('Prime numbers in the range %d--%d\n' % (start, end))
    timeme(start_time, 'doing preliminary stuff')

    # Finding primes starts here.
    start_time = time.time()
    total_primes = 0

    # To use PyCallGraph uncomment the PyCallGraph line and 
    # INDENT the for loop so its under the with PyCallGraph() loop.
    # with PyCallGraph(output=GraphvizOutput()):
    for n in range(start, end):
        if is_prime(n):
            total_primes += 1
            fh.write('%s\n' % n)
    
    timeme(start_time, 'finding primes')
    
    fh.close()
    print ('Found %d primes during this run.' % total_primes)

if __name__ == '__main__':
    main()

