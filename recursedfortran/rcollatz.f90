program CollatzProgram
        implicit none
        integer :: start, end, i, length
        integer(kind=8), allocatable :: numbers(:)
        integer, allocatable :: lengths(:)
        integer :: status
        character(len=100) :: arg1, arg2
        integer(kind=8), dimension(10) :: top_numbers   ! top 10 numbers
        integer, dimension(10) :: top_lengths           ! and corresponding sequence lengths 
        integer :: top_count
        logical :: found
        integer :: j, min_length, min_index
        integer :: num_elements

        call get_command_argument(1, arg1, status)
        call get_command_argument(2, arg2, status)

        if (command_argument_count() /= 2) then
                stop
        endif

        ! Parse args 
        read(arg1, *, iostat=status) start
        if (status /= 0) then
                print *, 'Error: Start value must be an integer.'
                stop
        endif

        read(arg2, *, iostat=status) end
        if (status /= 0) then
                print *, 'Error: End value must be an integer.'
                stop
        endif

        num_elements = end - start + 1                 ! calculate number of elements in the range

        allocate(numbers(num_elements))
        allocate(lengths(num_elements))

        top_numbers = -1_8
        top_lengths = -1
        top_count = 0

        ! Compute Collatz lengths for each number 
        do i = 1, num_elements
                numbers(i) = int(start + i - 1, kind=8)
                lengths(i) = collatz_length(numbers(i))
        end do

        ! Identify the top 10 numbers with the longest sequence 
        do i = 1, num_elements
                length = lengths(i)
                found = .false.
                ! ceck if the current length is already in the top results
                do j = 1, top_count
                        if (top_lengths(j) == length) then
                                found = .true.
                                if (numbers(i) < top_numbers(j)) then
                                        top_numbers(j) = numbers(i)
                                end if
                                exit
                        end if
                end do

                ! Add new length to the top results or replace the smallest if full
                if (.not. found) then
                        if (top_count < 10) then
                                top_count = top_count + 1
                                top_numbers(top_count) = numbers(i)
                                top_lengths(top_count) = length
                        else
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
                                        top_numbers(min_index) = numbers(i)
                                        top_lengths(min_index) = length
                                elseif (length == min_length .and. numbers(i) < top_numbers(min_index)) then
                                        top_numbers(min_index) = numbers(i)
                                end if
                        end if
                end if
        end do

        ! Sort the top results by sequence length
        call sort_top_results(top_numbers, top_lengths, top_count, .true.)

        print *, 'Sorted based on sequence length'
        do i = 1, top_count
                if (top_numbers(i) /= -1_8) then
                        print *, top_numbers(i), top_lengths(i)
                end if
        end do

        ! Sort the top results by integer value
        call sort_top_results(top_numbers, top_lengths, top_count, .false.)

        print *, ' '
        print *, 'Sorted based on integer size'
        do i = 1, top_count
                if (top_numbers(i) /= -1_8) then
                        print *, top_numbers(i), top_lengths(i)
                end if
        end do

contains

        ! Recursive function to calculate the Collatz sequence length
        recursive integer function collatz_length(n) result(len)
                implicit none
                integer(kind=8), intent(in) :: n
                if (n == 1_8) then              ! base case
                        len = 0
                else if (mod(n,2_8) == 0_8) then
                        len = 1 + collatz_length(n / 2_8)
                else
                        len = 1 + collatz_length(3_8*n + 1_8)
                end if
        end function collatz_length

        ! Subroutine to sort top results by sequence length or number
        subroutine sort_top_results(numbers, lengths, count, by_length)
                implicit none
                integer(kind=8), intent(inout) :: numbers(:)
                integer, intent(inout) :: lengths(:)
                integer, intent(in) :: count
                logical, intent(in) :: by_length
                integer :: i, j
                integer(kind=8) :: temp_num
                integer :: temp_length
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

