! ************************************************************************
! FILE: primes_serial.f90
! DESCRIPTION:
!   This program generates primes. The approach taken is a "brute force"
!   method which requires increasingly greater amounts of cpu as the problem
!   size increases.  It should lend itself well to an embarassingly parallel
!   solution since each prime can be computed independently of all other
!   primes.
! AUTHOR: Blaise Barney 11/25/95 - adapted from version contributed by
!   Richard Ng & Wong Sze Cheong during MHPCC Singapore Workshop (8/22/95).
! LAST REVISED: 04/02/05
!
! Explanation of constants and variables
!   LIMIT                  = Increase this to find more primes
!   PRINT                  = Print a line after this many numbers
!   rank                   = task identifier
!   pc                     = prime counter
!   foundone               = most recent prime found
!
! MRL Notes: original was parameter(LIMIT=1000000000)
! ************************************************************************

    program prime

    integer LIMIT, PRINT
    parameter(LIMIT=50000000)
    parameter(PRINT=1000000)

    integer n, pc, foundone
    logical result

    print *,'Starting. Numbers to be scanned =',LIMIT
!   Assume first four primes are counted here.
    pc = 4
    do n=11, LIMIT, 2
       call isprime(n,result)
       if (result .eqv. .true.) then
          pc = pc + 1
          foundone = n
!         ****** Optional: print each prime as it is found. ******
!         print *, foundone
!         ******
       endif
       if (mod(n-1,PRINT).eq.0) then
          print *,'Numbers scanned =',n-1,' Primes found = ',pc
       endif
    enddo
    print *,'Done. Largest prime is ',foundone,' Total primes ',pc
    end

    subroutine isprime (n,result)
    integer n
    logical result
    integer i, squareroot
    real*4 realn
    if (n .gt. 10) then
       realn = real(n)
       squareroot = int (sqrt(realn))
       do i=3,squareroot,2
         if (mod(n,i) .eq. 0) then
            result = .false.
            return
         endif
       enddo
       result = .true.
       return
!   Assume first four primes are counted elsewhere. Forget everything else.
    else
      result = .false.
      return
    endif
    end
