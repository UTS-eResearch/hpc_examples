#!/usr/bin/env python

# This program finds prime numbers. It was written as an example for 
# how to use the PBS job scheduler and how to write a program so that 
# it can pick up where it left off in case the program is terminated.
# 
# This program requires Python version 3.6 or later.
# 
# Adapted from: http://www.hlevkin.com/Shell_progr/hellopython.htm
#
# Input : None or a previous primes.txt file
# Output: primes.txt
#
# Author: Mike Lake

import os, sys

# Define a starting integer and a larger ending integer as a range, 
# within which to test for prime numbers. A range of 100000 to 200000 
# will take about 3 to 4 minutes. 
start = 100000
end   = 200000

###########
# Functions
###########

def get_last_prime():
    ''' 
    This will open the file "primes.txt" and try to convert the last
    line to an integer. This should be the last prime that was found. 
    Return that prime. 
    '''
    try:
        with open('primes.txt', 'r') as f:
            lines = f.readlines()
            last_line = lines[-1]
            last_prime = int(last_line)
    except IOError:
        print ('Error: Could not open existing file.')
        sys.exit(1)
    except ValueError:  
        print ('Error: Last line could not be converted to an integer.') 
        sys.exit(1)

    return last_prime

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

    # Check if an existing list of primes exists. 
    if os.path.exists('primes.txt'):
        # Add 1 to the last prime found and start looking again from there, 
        # appending to that existing file. 
        start = get_last_prime() + 1
        new_file = False
        print ('Found an existing file, starting from %d' % start)
    else:
        # Start looking for primes from scratch.
        new_file = True

    if start >= end:
        print ('Already finished.')
        sys.exit(1)
       
    # Open the output file for appending.
    fh = open('primes.txt', 'a+') 
    if new_file: 
        fh.write('Prime numbers in the range %d--%d\n' % (start, end))
 
    # Finding new primes starts here.
    total_primes = 0
    for n in range(start, end):
        if is_prime(n):
            total_primes += 1
            fh.write('%s\n' % n)
    
    fh.close()
    print ('Found %d primes during this run.' % total_primes)

if __name__ == '__main__':
    main()

