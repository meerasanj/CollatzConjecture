import sys

# method to compute the length of the Collatz sequence for a given number
def collatz_length(n):
    length = 0
    while n != 1:
        if n % 2 == 0:
            n //= 2
        else:
            n = 3 * n + 1
        length += 1
    return length

# method to find the 10 integers with the longest Collatz sequences in a given range
def find_top_10_collatz_numbers(start, end):
    collatz_list = []
    
    for num in range(start, end + 1):
        length = collatz_length(num)
        collatz_list.append((length, num))

    # sort the list by length descending, number ascending
    collatz_list.sort(key=lambda x: (-x[0], x[1]))

    top_combined = [] # store top numbers w unique lengths 
    seen_lengths = set()
    for length, num in collatz_list:
        if length not in seen_lengths:
            top_combined.append((num, length))
            seen_lengths.add(length)
        if len(top_combined) == 10:
            break
    return top_combined

# main method to handle overall program flow
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
        print(f"               {num}               {length}")

    print("\nSorted based on integer size")
    top_10.sort(key=lambda x: x[0], reverse=True)
    for num, length in top_10:
        print(f"               {num}               {length}")

if __name__ == "__main__":
    main()
