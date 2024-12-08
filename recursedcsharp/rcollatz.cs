using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;

class CollatzProgram {
	// Recursive method to compute the length of the Collatz sequence for a given number
	static int CollatzLength(BigInteger n) {
		if (n == 1)
			return 0;
		else if (n % 2 == 0)
            		return 1 + CollatzLength(n / 2);
        	else
            		return 1 + CollatzLength(3 * n + 1);
	}

	// Method to find the 10 integers with the longest Collatz sequences in a given range
	static List<(int Number, int Length)> FindTop10CollatzNumbers(int start, int end) {
		var topNumbers = new List<(int Number, int Length)>();

		for (int num = start; num <= end; num++) {
			int length = CollatzLength(num);
		
			// Check if we already have this length	
			var existing = topNumbers.FirstOrDefault(x => x.Length == length);
			if (existing.Length == length) {
				if (num < existing.Number) {
					topNumbers.Remove(existing);
					topNumbers.Add((num, length));
				}
			} else { // New length
				if (topNumbers.Count < 10) {
					topNumbers.Add((num, length));
				} else {
				// Top 10 is full, find the smallest length entry
					var minEntry = topNumbers
						.OrderBy(x => x.Length)
						.ThenByDescending(x => x.Number)
						.First();
					if (length > minEntry.Length) {
						topNumbers.Remove(minEntry);
						topNumbers.Add((num, length));
					} else if (length == minEntry.Length && num < minEntry.Number) {
						topNumbers.Remove(minEntry);
						topNumbers.Add((num, length));	
					}
				}
			}
		}

		// Sort by sequence length descending, then number ascending
		topNumbers = topNumbers
			.OrderByDescending(x => x.Length)
			.ThenBy(x => x.Number)
			.ToList();

		return topNumbers;	

	}

	// Main method to handle overall program flow
	static void Main(string[] args) {
		// Parse and validate command-line arguments
		if (!int.TryParse(args[0], out int start) || !int.TryParse(args[1], out int end)) {
			Console.WriteLine("Error: Start and end values must be integers.");
			return;
		}

		var top10 = FindTop10CollatzNumbers(start, end);
		Console.WriteLine("Sorted based on sequence length");
		foreach (var item in top10) {
			Console.WriteLine($"{item.Number,15}{item.Length,15}");
		}

		var sortedByNumber = top10.OrderByDescending(x => x.Number).ToList();
		Console.WriteLine("\nSorted based on integer size");
		foreach (var item in sortedByNumber) {
			Console.WriteLine($"{item.Number,15}{item.Length,15}");
		}
	}
}
