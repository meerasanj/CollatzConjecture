# Recursive function to calculate the length of the Collatz sequence for a given number `n`
function collatz_length(n)
    	if n == 1		# base case 
        	return 0	
    	elseif n % 2 == 0
        	return 1 + collatz_length(div(n, 2))
    	else
        	return 1 + collatz_length(3 * n + 1)
    	end
end

# Function to find the top 10 numbers with the longest Collatz sequences in a range
function find_top_10_collatz_numbers(start, end_)
	top_results = []        # small list of up to 10 results: (number, seq_length)
        for num in start:end_
                seq_length = collatz_length(num)

                # Check if this sequence length exists in top_results
                existing_index = findfirst(x -> x[2] == seq_length, top_results)
                if existing_index !== nothing
                        if num < top_results[existing_index][1]
                                top_results[existing_index] = (num, seq_length)
                        end
                else
                         # New length not in top_results
                        if length(top_results) < 10
                                push!(top_results, (num, seq_length))
                        else
                                min_length = top_results[1][2]
                                min_index = 1
                                for i in 2:length(top_results)
                                        l = top_results[i][2]
                                        if l < min_length
                                                min_length = l
                                                min_index = i
                                        elseif l == min_length && top_results[i][1] > top_results[min_index][1]
                                                min_index = i
                                        end
                                end

                                if seq_length > min_length
                                        top_results[min_index] = (num, seq_length)
                                elseif seq_length == min_length && num < top_results[min_index][1]
                                        top_results[min_index] = (num, seq_length)
                                end
                        end
                end
        end

	sort!(top_results, by = x -> (-x[2], x[1]))
	return top_results
end

# main method to handle overall program flow 
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
