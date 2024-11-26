# Function to calculate the length of the Collatz sequence for a given number `n`
function collatz_length(n)
	seq_length = 0
    	while n != 1
        	if n % 2 == 0
            		n = div(n, 2)
        	else
            		n = 3 * n + 1
        	end
        	seq_length += 1
    	end
    	return seq_length
end

# Function to find the top 10 numbers with the longest Collatz sequences in a range
function find_top_10_collatz_numbers(start, end_)
    	collatz_list = [] # List to store (sequence length, number)
    	for num in start:end_
        	seq_length = collatz_length(num)	# compute
        	push!(collatz_list, (seq_length, num))	# add pair to list 
    	end

	# Sort the list by sequence length descending, then by number ascending
    	sort!(collatz_list, by = x -> (-x[1], x[2]))
    	top_combined = []				# List to store the top 10 result
    	seen_lengths = Set{Int}()			# Set to keep track of unique sequence lengths
    
	for (seq_length, num) in collatz_list
        	if seq_length ∉ seen_lengths		# checks if unique sequence length
            		push!(top_combined, (num, seq_length))
            		push!(seen_lengths, seq_length)
        	end
        	if length(top_combined) == 10
            		break
        	end
    	end
    	return top_combined
end

# Main method to handle overall program flow 
function main()
    	if length(ARGS) != 2
        	println("Usage: julia collatz.jl <start> <end>")
        	exit(1)
    	end

    	start = parse(Int, ARGS[1])
    	end_ = parse(Int, ARGS[2])
    
    	top_10 = find_top_10_collatz_numbers(start, end_)
    	println("Sorted based on sequence length")
    	for (num, seq_length) in top_10
        	println(lpad(string(num), 15), lpad(string(seq_length), 15))
    	end
    
	println("\nSorted based on integer size")
    	sort!(top_10, by = x -> -x[1])
    	for (num, seq_length) in top_10
        	println(lpad(string(num), 15), lpad(string(seq_length), 15))
    	end
end

main()
