# Description: Finds prime numbers within a given range.
# Usage "Rscript script_name start end"
# Author: Mike Lake
# Versions:
# 2013.03.20  First version
# 2025.05.02  Added writing to data and log file.

usage <- function() {
    cat ('\nFinding Primes')
    cat ('Usage: script_name m n \n')
    cat ('where m>1, n>m and both are integers.\n\n')
    q()
}

# Check correct number of args was given.
args = commandArgs(trailingOnly=TRUE)
if (is.null(args) | length(args) != 2) {
    usage()
}

# Range over which to search for primes.
start = as.numeric(args[1])
end   = as.numeric(args[2])

# start must be > 1 otherwise this code will do a 2%%0 which is NA.
# Also end needs to be > start.
if ( start < 2 | end < start ) {
    usage()
}

# Open two file connections. One will be for the large data, 
# the other will be to write a log file to show progress.
dataConn <- file("primes.txt", "w")
logConn  <- file("primes.log", "w")

# Print what is being done to the console and also to our log file.
# Using cat instead of print hides the line numbers like [1] 
cat ('Finding Primes from ', start, 'to ', end, '\n')
cat ('Finding primes from ', start, 'to ', end, '\n', file=logConn)

# This can be used to save each prime found into an array.
# In cases where the data is large, you don't want to do this
# as it will use memory. Hence use of this array is commented out.
#primes_array = c()

# This is a simple method to find primes. For each number "i" to test we
# start by assuming it might be prime. Then we just try to divide it by
# the numbers 2 to i-1. We don't try to divide it by 1 or itself. 
# If there is no remainder upon division (i.e. remainder==0) then it can't
# be a prime number and so we set the prime flag to false. We then break 
# the loop as no need to test further divisors. If at the end of the loop
# the prime flag its still set to true then there were no divisors found 
# and it is therefore a prime.
total_primes <- 0
for (i in start:end) {
    prime = TRUE   # Initially assume the number is a prime.
    # Check if this number is a prime.
    # Note we have to surround (i-1) to get the operator precedence correct. 
    for (j in 2:(i-1)) {
        if (i%%j == 0) {
            # No remainder on division i/j so i can't be a prime.
            prime = FALSE
            break
        }
    }
    if (prime == TRUE) {
        total_primes = total_primes + 1
        #primes_array = c(primes_array, i)
        writeLines(paste(i), dataConn)
        flush(dataConn)
    }
    # Every "N" lines print progress.
    if (i%%1000 == 0) {
        writeLines(paste(i), logConn) # Prints progress to log file.
        flush(logConn)
        # We do not want to write to the console as we will only see that
        # after the PBS job has finished.
        #cat (i, ' ') # Prints progress to console.
        #flush.console(); Sys.sleep(1)
    } 
}

# Close the connections to the files.
close(dataConn)
close(logConn)

#cat ("\nTotal primes found = ", length(primes_array), '\n')
cat ("\nTotal primes found = ", total_primes, '\n')

