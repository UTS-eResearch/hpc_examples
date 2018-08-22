#!/usr/bin/env python

# Program to display data from cProfile in different ways.

import pstats

p = pstats.Stats('profile.dat')

def sort_by(*args):
    # This just prints a heading above the data set.
    print ('------------------------------------------------------')
    print ('Sorting by: ', ', '.join(args))
    print ('------------------------------------------------------')

# Strip leading path information from file names. This reduces the width of the output. 
p.strip_dirs()

sort_by('calls')
p.sort_stats('calls').print_stats(6)

sort_by('time')
p.sort_stats('time').print_stats(6)

sort_by('time', 'cumulative')
p.sort_stats('time', 'cumulative').print_stats(6)

sort_by('time', 'restrict to is_prime')
p.sort_stats('time').print_stats(6, 'is_prime')

