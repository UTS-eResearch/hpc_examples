#! /usr/bin/env python

# This program finds prime numbers. It was written as an example for 
# how to use the PBS job scheduler and how to write a program so that 
# it can pick up where it left off in case the program is terminated.
# 
# Adapted from: http://www.hlevkin.com/Shell_progr/hellopython.htm
#
# Input : None or a previous primes.txt file
# Output: primes.txt
#
# Author: Mike Lake

import os, sys

# Define a default start value and the number of subsequent integers to test for primeness. 
start = 5
end = 10000

###########
# Functions
###########

def get_last_prime():
    ''' 
    This function will open the file "primes.txt" and try to convert the 
    last line to an integer. This should be the last prime that was found. 
    Return that prime. 
    '''
    try:
        with open('primes.txt', 'r') as f:
            lines = f.readlines()
            last_line = lines[-1]
            last_prime = int(last_line)
    except IOError:
        print 'Error: Could not open existing file.'
        sys.exit(1)
    except ValueError:  
        print 'Error: Last line could not be converted to an integer.' 
        sys.exit(1)

    return last_prime

##########################
# Main program starts here
##########################

def main():

    global start

    # Check if an existing list of primes exists. 
    if os.path.exists('primes.txt'):
        # Add 1 to the last prime found and start looking again from there, 
        # appending to that existing file. 
        start = get_last_prime() + 1
        file_write_mode = 'a'
    else:
        # Start looking for primes from scratch.
        file_write_mode = 'w'
    
    print 'Prime Number Finder'
    print 'Looking for prime numbers in the range %d to %d ...' % (start, end)
   
    # Open the output file, either as write or append mode, with no buffering. 
    fh = open('primes.txt', file_write_mode, 0) 
    if file_write_mode == 'w':
        fh.write('Prime numbers in the range %d--%d\n' % (start, end))
    
    # Finding new primes starts here
    total_primes = 0
    for n in range(start, end):
        print n, '\r', 
        for x in range(2, n):
            if n % x == 0:
                # There is a factor so this n is not a prime.
                # print n, 'equals', x, '*', n/x
                break
        else:
            # The loop fell through without finding a factor
            # so this number is a prime.
            # print n
            total_primes += 1
            fh.write('%s\n' % n)
    
    fh.close()
    print 'Found %d primes during this run.' % total_primes

if __name__ == '__main__':
    main()

