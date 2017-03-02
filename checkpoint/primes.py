#!/usr/bin/env python

# Finds prime numbers.
# Adapted from: http://www.hlevkin.com/Shell_progr/hellopython.htm
# 
# This version of the program does checkpointing and you can also 
# get the program to kill itself in order to test the checkpointing.
# 
# Input : none
# Output: output.txt
#         state.txt
# 
# Author: Mike Lake
# Date:   2017.02.21

import os, sys, time
import subprocess

##############################
# User parameters are set here.
##############################

# First number to start at and last number to end at to check for primes.
start = 100000
end   = 200000

# Total number of check points within the range start to end. 
# Set it to 0 for no checks.
num_checks = 10

# The step number to kill this program at if we wish to. Set it 
# to a negative number if you dont want to kill this script.
kill_at = -9600

restart = False

###########
# Functions 
###########

def checkpoint (n):
    '''
    Takes an integer 'n' and saves that integer to the "state" file.   
    '''
    fh_state.seek(0)
    fh_state.truncate()
    fh_state.write('%d' % n)
    fh_state.flush()

def do_something_bad():
    '''
    This just simulates something bad happening to the program so 
    we can test our checkpointing and restarting.
    '''

    pid = os.getpid()  # This is only needed for our special kill section.
    time.sleep(1)

    # Does not seem to work 
    #subprocess.call(["chmod", "ug-w", "output.txt" ])

    # Exit_status=1 
    # ValueError: I/O operation on closed file
    #fh.close()
    
    # Exit_status=137
    #subprocess.call(["kill", "-9", "%d" % pid])  
    
    # Exit_status=143
    # /var/spool/PBS/mom_priv/jobs/419210.hpcnode1.SC: line 13: 38511 Terminated 
    #subprocess.call(["kill", "-15", "%d" % pid])  


def calculate_primes (start, end, checks_at):
    '''
    Takes the first and last numbers being the range over which we wish to check 
    for primality and a list of numbers being the points we wish to checkpoint at.
    '''
    total_primes = 0
    for n in range(start, end):
        for x in range(2, n):
            if n % x == 0:
                # There is a factor so this n is not a prime.
                break
        else:
            # The loop fell through without finding a factor
            # so this number is a prime.
            total_primes += 1
            fh.write('%s\n' % n)
            fh.flush()
   
        # Check for and do any checkpointing. 
        #time.sleep(1)
        if n in checks_at: 
            print 'Checkpointed at step %d' % n
            checkpoint(n)
   
        # Here is our special kill section for testing checkpointing. 
        if n == kill_at:
            print 'Something wicked occurred at step %d' % n
            do_something_bad()

    return total_primes


##########################
# Main program starts here
##########################

if __name__ == '__main__':

    print 'Prime Number Finder'
    print 'Looking for prime numbers in the range %d--%d ...' % (start, end)
  
    # Here we create a list of the numbers at which we wish to checkpoint.  
    # Example: for primes between 9000 and 10,000 we might want to have 10 
    # checks so we calculate (10,000-9000)/10 = 100 and then generate a 
    # range of numbers from 9000 to 10,000 every 100 steps i.e. 
    # 9000, 9100, 9200, 9300, 9400, 9500, 9600, 9700, 9800, 9900]
    if num_checks != 0:
        checks_at = range(start, end, (end-start)/num_checks)
        print 'Checkpointing at ', checks_at[0:3], '...', checks_at[-4:-1]
    else:
        checks_at = []
        print 'No checkpointing will be done.'

    # Check if a state file exists from the last run. If so we need to open it,
    # and read the contents for the state from which to start again.
    if os.path.exists('state.txt'):
        fh_state = open('state.txt', 'r') 
        try:
            last = int(fh_state.read()) 
        except:
            print 'Error in opening the state file.'
        fh_state.close()
        print 'Found a previous state file, starting from %d' % last
        restart = True
        start = last 
    
    # Open file for saving state. Note we use 0 to set flush() immediate 
    # so there is no buffering.
    fh_state = open('state.txt', 'w', 0) 

    # Open the output file for your results. Note that we append. 
    fh = open('output.txt', 'a') 
    
    # Now we do the main work here.
    fh.write('Prime numbers in the range %d--%d\n' % (start, end))
    total_primes = calculate_primes (start, end, checks_at)
    print 'Found %d primes' % total_primes
   
    # Finished, cleanup, including removing the state file as its no longer wanted.    
    fh.close()
    fh_state.close()
    os.remove('state.txt')


