program CollatzProgram
        implicit none
        integer :: start, end_, i, length
        integer(kind=8) :: num
        integer(kind=8), dimension(10) :: top_numbers  ! top 10 numbers
        integer, dimension(10) :: top_lengths          ! corresponding sequence lengths
        integer :: top_count
        integer :: status
        character(len=100) :: arg1, arg2
        logical :: found
        integer :: j, min_length, min_index
        
        call get_command_argument(1, arg1, status)
        call get_command_argument(2, arg2, status)

        if (command_argument_count() /= 2) then
                print *, 'Usage: collatz <start> <end>'
                stop
        endif

        ! Parse start and end args 
        read(arg1, *, iostat=status) start
        if (status /= 0) then
                print *, 'Error: Start value must be an integer.'
                stop
        endif 

        read(arg2, *, iostat=status) end_
        if (status /= 0) then
                print *, 'Error: End value must be an integer.'
                stop
        endif

        top_numbers = -1_8
        top_lengths = -1
        top_count = 0

        ! Compute Collatz sequence lengths for all numbers in the range
        do num = start, end_
                length = collatz_length(num)
                !check if the current length is already in the top results
                found = .false.
                do j = 1, top_count
                        if (top_lengths(j) == length) then
                                found = .true.
                                if (num < top_numbers(j)) then
                                        top_numbers(j) = num
                                end if
                                exit
                        end if
                end do

                ! add to top results if not found 
                if (.not. found) then
                        if (top_count < 10) then
                                top_count = top_count + 1
                                top_numbers(top_count) = num
                                top_lengths(top_count) = length
                        else                    ! Replace the smallest value in the top 10 if the current one is larger
                                min_length = top_lengths(1)
                                min_index = 1
                                do j = 2, top_count
                                        if (top_lengths(j) < min_length) then
                                                min_length = top_lengths(j)
                                                min_index = j
                                        elseif (top_lengths(j) == min_length .and. top_numbers(j) > top_numbers(min_index)) then
                                                min_index = j
                                        end if
                                end do
                                if (length > min_length) then
                                        top_numbers(min_index) = num
                                        top_lengths(min_index) = length
                                elseif (length == min_length .and. num < top_numbers(min_index)) then
                                        top_numbers(min_index) = num
                                end if
                        end if
                end if
        end do

        ! Sort top results by sequence length descending
        call sort_top_results(top_numbers, top_lengths, top_count, .true.)

        print *, 'Sorted based on sequence length'
        do i = 1, top_count
                if (top_numbers(i) /= -1_8) then
                        print *, top_numbers(i), top_lengths(i)
                end if
        end do

        ! Sort top results by integer value descending
        call sort_top_results(top_numbers, top_lengths, top_count, .false.)

        print *, ' '
        print *, 'Sorted based on integer size'
        do i = 1, top_count
                if (top_numbers(i) /= -1_8) then
                        print *, top_numbers(i), top_lengths(i)
                end if
        end do

contains

        ! Function to compute the length of the Collatz sequence for a given number
        integer function collatz_length(n)
                implicit none
                integer(kind=8), intent(in) :: n
                integer(kind=8) :: num
                integer :: len
                num = n
                len = 0
                do while (num /= 1_8)
                        if (mod(num, 2_8) == 0_8) then
                                num = num / 2_8
                        else
                                num = 3_8 * num + 1_8
                        end if
                        len = len + 1
                end do
                collatz_length = len
        end function collatz_length

         ! Subroutine to sort top results by length or number
        subroutine sort_top_results(numbers, lengths, count, by_length)
                implicit none
                integer(kind=8), intent(inout) :: numbers(:)
                integer, intent(inout) :: lengths(:)
                integer, intent(in) :: count
                logical, intent(in) :: by_length
                integer :: i, j, temp_length
                integer(kind=8) :: temp_num
                do i = 1, count - 1
                        do j = i + 1, count
                                if (by_length) then
                                        if (lengths(j) > lengths(i) .or. (lengths(j) == lengths(i) .and. numbers(j) < numbers(i))) then
                                                temp_length = lengths(i)
                                                lengths(i) = lengths(j)
                                                lengths(j) = temp_length
                                                temp_num = numbers(i)
                                                numbers(i) = numbers(j)
                                                numbers(j) = temp_num
                                        end if
                                else
                                        if (numbers(j) > numbers(i)) then
                                                temp_length = lengths(i)
                                                lengths(i) = lengths(j)
                                                lengths(j) = temp_length
                                                temp_num = numbers(i)
                                                numbers(i) = numbers(j)
                                                numbers(j) = temp_num
                                        end if
                                end if
                        end do
                end do
        end subroutine sort_top_results

end program CollatzProgram
