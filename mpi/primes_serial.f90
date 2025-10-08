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
! MRL Notes: Original is parameter(LIMIT=1000000000) i.e. 1,000 million.
!            Changed print formatting a bit. 
! ************************************************************************

    program primes

    integer LIMIT, PRINT
    ! Find primes up to 100,000,000 i.e. 100 million.
    parameter(LIMIT=100000000)
    ! After each set of 10,000,000 numbers are scanned, print the number of primes found.
    parameter(PRINT=10000000)
    102 FORMAT(I9)

    integer n, pc, foundone
    logical result
    open(1, file = 'primes.txt', status = 'replace')
    print *,'Starting. Numbers to be scanned =',LIMIT
    ! Assume the first four primes are counted here.
    pc = 4
    do n=11, LIMIT, 2
       call isprime(n,result)
       if (result .eqv. .true.) then
          pc = pc + 1
          foundone = n
          ! ****** Uncomment this to print each prime as it is found.
          ! print *, foundone
          write(1,102) foundone
       endif
       if (mod(n-1,PRINT).eq.0) then
          print *,'Numbers scanned =',n-1,' Primes found = ',pc
       endif
    enddo
    print *,'Done. Largest prime is ',foundone,' Total primes ',pc
    close(1)
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
    ! Assume the first four primes are counted elsewhere. Forget everything else.
    else
      result = .false.
      return
    endif
    end

