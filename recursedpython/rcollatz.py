import sys
sys.setrecursionlimit(10**7)  # Increase recursion limit if dealing with large numbers

# Recursive method to compute the length of the Collatz sequence for a given number
def collatz_length(n):
    if n == 1:
        return 0
    elif n % 2 == 0:
        return 1 + collatz_length(n // 2)
    else:
        return 1 + collatz_length(3 * n + 1)

# Method to find the 10 integers with the longest Collatz sequences in a given range
def find_top_10_collatz_numbers(start, end):
    top_results = []    # list of (length, num) with at most 10 entries
    seen_lengths = {}   

    for num in range(start, end + 1):
        clength = collatz_length(num)

        # Check if we have seen this length before
        if clength in seen_lengths:
            # If the current number is smaller, update it
            if num < seen_lengths[clength][1]:
                seen_lengths[clength] = (clength, num)
        else:
            if len(top_results) < 10:   # new length found 
                top_results.append((clength, num))
                seen_lengths[clength] = (clength, num)
            else:
            # top_results full, then check if the new length is better than the smallest one
                top_results.sort(key=lambda x: x[0])
                smallest_length, smallest_num = top_results[0]  # Sort by length ascending to find the smallest length easily
                if clength > smallest_length:
                    removed_length = top_results.pop(0)     # remove smallest and add new one 
                    del seen_lengths[removed_length[0]]
            
                    top_results.append((clength, num))
                    seen_lengths[clength] = (clength, num)
    
    # Sort by length descending, then number ascending
    top_results.sort(key=lambda x: (-x[0], x[1]))
    final_top_10 = [(num, length) for length, num in top_results]   # convert to (num, length) format
    return final_top_10    

def main():
    if len(sys.argv) != 3:
        print("Usage: python collatz.py <start> <end>")
        sys.exit(1)

    start, end = map(int, sys.argv[1:3])

    if start > end:
        print("Error: Start value must be less than or equal to end value.")
        sys.exit(1)

    top_10 = find_top_10_collatz_numbers(start, end)

    print("Sorted based on sequence length")
    for num, length in top_10:
        print(f"{num:>15} {length:>15}")

    print("\nSorted based on integer size")
    # Sort by integer value descending
    top_10.sort(key=lambda x: -x[0])
    for num, length in top_10:
        print(f"{num:>15} {length:>15}")

if __name__ == "__main__":
    main()
