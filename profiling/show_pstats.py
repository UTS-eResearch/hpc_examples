#!/usr/bin/env python3

# Program to display statistics from cProfile output in different ways.

import sys, pstats

def sort_by(*args):
    # This just prints a heading above the data set.
    print ('------------------------------------------------------')
    print ('Sorting by: ', ', '.join(args))
    print ('------------------------------------------------------')

# Load the profile statistics file, else exit.
try:
    p = pstats.Stats('profile.dat')
except IOError:
    print("The file 'profile.dat' could not be loaded. Exiting.")
    sys.exit()    

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

