import sys

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
    collatz_list = []
    for num in range(start, end + 1):
        length = collatz_length(num)
        collatz_list.append((length, num))
    
    # Sort by sequence length descending, then by number ascending
    collatz_list.sort(key=lambda x: (-x[0], x[1]))
    
    # Collect the top 10 numbers with unique sequence lengths
    top_combined = []
    seen_lengths = set()
    for length, num in collatz_list:
        if length not in seen_lengths:
            top_combined.append((num, length))
            seen_lengths.add(length)
        if len(top_combined) == 10:
            break
    return top_combined

# Main method to handle overall program flow
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
