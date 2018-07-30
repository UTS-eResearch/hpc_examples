#!/usr/bin/env python

# Finds prime numbers.
# Adapted from: http://www.hlevkin.com/Shell_progr/hellopython.htm
#
# Input : none
# Output: primes.txt

import os

# A range of 100000 to 200000 will take about 30 seconds.
start = 100000
end   = 200000

print 'Prime Number Finder'
print 'Looking for prime numbers in the range %d--%d ...' % (start, end)

fh = open('primes.txt', 'w') 
fh.write('Prime numbers in the range %d--%d\n\n' % (start, end))

total_primes = 0
for n in range(start, end):
    for x in range(2, n):
        if n % x == 0:
            # There is a factor so this n is not a prime.
            # print n, 'equals', x, '*', n/x
            break
    else:
        # The loop fell through without finding a factor
        # so this number is a prime.
        #print n
        total_primes += 1
        fh.write('%s\n' % n)

fh.close()

print 'Found %d primes' % total_primes

