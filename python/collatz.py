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
    # Dictionary: key = length, value = smallest number achieving that length
    length_to_num = {} # will store only one entry per unique sequence length

    for num in range(start, end + 1):
        clength = collatz_length(num)
        if clength not in length_to_num or num < length_to_num[clength]:
            length_to_num[clength] = num

    # Convert dictionary to a list of (num, length) pairs
    length_num_pairs = [(num, length) for length, num in length_to_num.items()]
    length_num_pairs.sort(key=lambda x: (-x[1], x[0]))  # Sort by length descending and then by number ascending
        
    top_10 = length_num_pairs[:10]
    return top_10

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
