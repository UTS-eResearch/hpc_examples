#!/usr/bin/env python

# This program finds prime numbers. It was written as an example for 
# how to use the PBS job scheduler and PBS array jobs. 
# 
# Adapted from: http://www.hlevkin.com/Shell_progr/hellopython.htm
#
# Input : Two integer args; starting and ending values.
# Output: primes.txt
#
# Author: Mike Lake

import sys

###########
# Functions
###########

def is_prime(n):
    '''
    Tests a number "n" to see if its a prime.
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

    # Get the starting integer and the ending integer.
    if len(sys.argv) != 3:
        print "Usage: %s start end" % sys.argv[0]
        print "Where start is an integer to start searching from"
        print "and end is an integer to end searching at."
        sys.exit()
        
    try:
        start = int(sys.argv[1])
        end = int(sys.argv[2])
    except:
        print "One of your arguments was not an integer."
        sys.exit()

    print "Prime Number Finder"
    print "Looking for prime numbers in the range %d to %d ..." % (start, end)

    # Finding primes starts here.
    total_primes = 0
    for n in range(start, end):
        if is_prime(n):
            total_primes += 1
            print "%d" % n
    
if __name__ == "__main__":
    main()

