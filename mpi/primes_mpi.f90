! ****************************************************************************
! DESCRIPTION:
! Generates prime numbers. All tasks distribute the work evenly, taking
! every nth number, where n is the stride computed as: (rank *2) + 1
! so that even numbers are automatically skipped. The method of using
! stride is preferred over contiguous blocks of numbers, since numbers
! in the higher range require more work to compute and may result in
! load imbalance. This program demonstrates embarrassing parallelism.
! Collective communications calls are used to reduce the only two data
! elements requiring communications: the number of primes found and
! the largest prime.
! 
! AUTHOR: Blaise Barney 11/25/95 - adapted from version contributed by
! Richard Ng & Wong Sze Cheong during MHPCC Singapore Workshop (8/22/95).
! 04/02/05
! 
! Explanation of constants and variables
!   LIMIT    = increase this to find more primes
!   FIRST    = rank of first task
!   ntasks   = total number of tasks in partitiion
!   rank     = task identifier
!   n        = loop variable
!   pc       = prime counter
!   pcsum    = number of primes found by all tasks
!   foundone = most recent prime found
!   maxprime = largest prime found
!   mystart  = where to start calculating
!   stride   = calculate every nth number
 
PROGRAM PRIME
    IMPLICIT NONE
    ! INTEGER mpi_comm_world, mpi_integer, mpi_max, mpi_sum, MPI_WTIME
    INCLUDE 'mpif.h'
 
    INTEGER LIMIT , FIRST
    PARAMETER (LIMIT=100000000)
    PARAMETER (FIRST=0)
 
    INTEGER ntasks, rank, ierr, n, pc, pcsum, foundone, &
        maxprime, mystart, stride
    DOUBLE PRECISION start_time, end_time
    LOGICAL result
 
    CALL MPI_INIT(ierr)
    CALL MPI_COMM_RANK(mpi_comm_world, rank, ierr)
    CALL MPI_COMM_SIZE(mpi_comm_world, ntasks, ierr)
    IF ( (MOD(ntasks,2).NE.0) .OR. (MOD(LIMIT,ntasks).NE.0) ) THEN
         PRINT *, MOD(ntasks,2), MOD(LIMIT,ntasks)
         PRINT *, 'Sorry -this exercise requires an even number of '
         PRINT *, 'processors evenly divisible into ', LIMIT, '.'
         PRINT *, 'Try 4 or 8.'
         CALL MPI_FINALIZE(ierr)
         STOP
    ENDIF
 
    ! Initializations: mystart must be odd number. stride is multiplied
    ! by 2 to skip over even numbers.
    start_time = MPI_WTIME()
    mystart = (rank*2) + 1
    stride = ntasks*2
    pc = 0
    foundone = 0
 
    ! --------- task with rank 0 does this part -------------
    IF ( rank.EQ.FIRST ) THEN
        PRINT *, 'Using', ntasks, 'tasks to scan', LIMIT, 'numbers'
        ! Assume first four primes are counted here
        pc = 4
        DO n = mystart, LIMIT, stride
            CALL ISPRIME(n, result)
            IF ( result .EQV. .TRUE. ) THEN
                pc = pc + 1
                foundone = n
                ! Print each prime as it is found.
                ! PRINT *, foundone
            ENDIF
         ENDDO
         CALL MPI_REDUCE(pc, pcsum, 1, mpi_integer, mpi_sum, FIRST, &
            mpi_comm_world, ierr)
         CALL MPI_REDUCE(foundone, maxprime, 1, mpi_integer, mpi_max, FIRST, &
            mpi_comm_world,ierr)
         end_time = MPI_WTIME()
         PRINT *, 'Done. Largest prime is ', maxprime, &
            ' Total primes ', pcsum
         PRINT *, 'Wallclock time elapsed: ', end_time - start_time
    ENDIF
 
    ! ------------------- all other tasks do this part ----------------
    IF ( rank.GT.FIRST ) THEN
    ! PRINT *, 'from process ', rank
        DO n = mystart, LIMIT, stride
            CALL ISPRIME(n,result)
            IF ( result .EQV. .TRUE. ) THEN
                pc = pc + 1
                foundone = n
                ! Print each prime as it is found.
                ! PRINT *, foundone
            ENDIF
        ENDDO
        CALL MPI_REDUCE(pc, pcsum, 1, mpi_integer, mpi_sum, FIRST, &
            mpi_comm_world, ierr)
        CALL MPI_REDUCE(foundone, maxprime, 1, mpi_integer, mpi_max, FIRST, &
            mpi_comm_world, ierr)
    ENDIF
 
    CALL MPI_FINALIZE(ierr)
    END
 
 
SUBROUTINE ISPRIME (N, Result)
    IMPLICIT NONE
    INTEGER N
    LOGICAL Result
    INTEGER i, squareroot
    REAL*4 realn
    IF ( N.GT.10 ) THEN
        realn = REAL(N)
        squareroot = INT(SQRT(realn))
        DO i = 3, squareroot, 2
            IF ( MOD(N,i).EQ.0 ) THEN
                Result = .FALSE.
                RETURN
            ENDIF
        ENDDO
        Result = .TRUE.
        RETURN
    ! Assume first four primes are counted elsewhere. 
    ! Forget everything else.
    ELSE
        Result = .FALSE.
        RETURN
    ENDIF
    END
