using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;

class CollatzProgram {
	// Method to compute the length of the Collatz sequence for a given number
	static int CollatzLength(int n) {
		int length = 0;
        	BigInteger number = n; // using long to prevent overflow

		while (number != 1) {
			if (number % 2 == 0)
                		number /= 2;
            		else
                		number = 3 * number + 1;
            			
			length++;
		}
		return length;
	}

	// Method to find the 10 integers with the longest Collatz sequences in a given range
	static List<(int Number, int Length)> FindTop10CollatzNumbers(int start, int end) {
		var collatzList = new List<(int Number, int Length)>();

		for (int num = start; num <= end; num++) {
			int length = CollatzLength(num);
			collatzList.Add((num, length));
		}

		// Sort by sequence length descending, then by number ascending
		var sortedList = collatzList
            		.OrderByDescending(x => x.Length)
            		.ThenBy(x => x.Number)
            		.ToList();

		// Collect the top 10 numbers with unique sequence lengths
		var topCombined = new List<(int Number, int Length)>();
        	var seenLengths = new HashSet<int>();
			
		foreach (var item in sortedList) {
			if (!seenLengths.Contains(item.Length)) {
				topCombined.Add(item);
				seenLengths.Add(item.Length);
			}
			if (topCombined.Count == 10)
				break;
		}
		return topCombined;
	}

	// Main method to handle overall program flow
	static void Main(string[] args) {
		int start = 0;
		int end = 0;

		if (args.Length != 2) {
			Console.WriteLine("Usage: CollatzProgram <start> <end>");
			return;
		}

		// parse command line args into integers 
		if (!int.TryParse(args[0], out start) || !int.TryParse(args[1], out end)) {
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
