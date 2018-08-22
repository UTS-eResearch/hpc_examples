#!/usr/bin/env python

# This program finds prime numbers. 
# This is written as an example for how to use the Python Profiler 
# which can show you how much time is spent in each part of your program.
#
# This program requires Python version 3.6 or later.
# 
# Input : None or a previous primes.txt file
# Output: primes.txt
#
# Author: Mike Lake

# Profile with: pycallgraph graphviz -- ./primes.py
from pycallgraph import PyCallGraph
from pycallgraph.output import GraphvizOutput
# with PyCallGraph(output=GraphvizOutput()):
#     do code

import os, sys, time

# Define a starting integer and a larger ending integer as a range, 
# within which to test for prime numbers. A range of 100000 to 200000 
# will take about 3 to 4 minutes. 
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
    for n in range(start, end):
        if is_prime(n):
            total_primes += 1
            fh.write('%s\n' % n)
    
    timeme(start_time, 'finding primes')
    
    fh.close()
    print ('Found %d primes during this run.' % total_primes)

if __name__ == '__main__':
    #with PyCallGraph(output=GraphvizOutput()):
    main()

