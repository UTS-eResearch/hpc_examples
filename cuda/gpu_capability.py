#!/usr/bin/env python

""" 
Lists capability of the GPU.
Mike Lake, July 2014 
"""

import sys

try:
    from pycuda import tools
    # We still need to initialize the device
    import pycuda.autoinit
except:
    print 'Did you set the CUDA environment?'
    print 'Apparently not. Exiting.'
    sys.exit()

# Get the device data. 
print '\nDaviceData: '
dd = tools.DeviceData()
print dd.__dict__

# You can now do queries like this:
#print 'max threads=%d' % dd.max_threads

print '\nList of specifications:'
specs = dd.__dict__
for key in specs.keys():
    print '  ', key, specs[key]



