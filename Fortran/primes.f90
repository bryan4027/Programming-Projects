program prime
    implicit none

    integer :: num_primes, found, numb
    logical :: isprime
    integer, allocatable, dimension(:) :: primes ! array that will hold the \
primes
    read *, num_primes
    found = 0;
    numb = 2
    do
        isprime = check_if_prime(numb)
        if (isprime) then
                    found = found + 1

                    print *, numb
                end if
                numb = numb + 1
                if (found == num_primes) then ! stop when all primes are fou\
nd
                    exit

                end if
            end do
    contains
    logical function check_if_prime(num)
    implicit none
    integer :: i, num

            check_if_prime = .true. ! assume prime
            do i = 2, num-1
                if ( mod(num, i) == 0) then ! if divisible by any other elem\
ent
                    check_if_prime = .false.               ! in the array, t\
hen not prime.
                    exit
                end if
            end do
            end function check_if_prime
    end program prime
