use std::env;
use std::collections::HashSet;

// Recursive function to calculate the length of the Collatz sequence for a given number `n`
fn collatz_length(n: u64) -> u32 {
    if n == 1 {     // base case 
        0
    } else if n % 2 == 0 {
        1 + collatz_length(n / 2)
    } else {
        1 + collatz_length(3 * n + 1)
    }
}

// Function to find the top 10 numbers with the longest Collatz sequences in the range [start, end]
fn find_top_10_collatz_numbers(start: u64, end: u64) -> Vec<(u64, u32)> {
    let mut collatz_list = Vec::new();      // List to store (sequence length, number)
    for num in start..=end {
        let length = collatz_length(num);
        collatz_list.push((length, num));
    }

    // Sort the list by sequence length descending, then by number ascending
    collatz_list.sort_unstable_by(|a, b| {
        b.0.cmp(&a.0).then_with(|| a.1.cmp(&b.1))
    });

    let mut top_combined = Vec::new();
    let mut seen_lengths = HashSet::new();
    
    for (length, num) in collatz_list {
        if !seen_lengths.contains(&length) {     // checks if sequence length is unique
            top_combined.push((num, length));
            seen_lengths.insert(length);
        }
        if top_combined.len() == 10 {
            break;
        }
    }
    top_combined
}

// main method to handle overall program flow 
fn main() {
    let args: Vec<String> = env::args().collect();
    let start = args[1].parse::<u64>().unwrap_or_else(|_| {
        println!("Error: Start value must be an integer.");
        std::process::exit(1);
    });
    let end = args[2].parse::<u64>().unwrap_or_else(|_| {
        println!("Error: End value must be an integer.");
        std::process::exit(1);
    });

    let mut top_10 = find_top_10_collatz_numbers(start, end);
    println!("Sorted based on sequence length");
    for (num, length) in &top_10 {
        println!("{:>15}{:>15}", num, length);
    }

    println!("\nSorted based on integer size");
    top_10.sort_unstable_by(|a, b| b.0.cmp(&a.0));
    for (num, length) in &top_10 {
        println!("{:>15}{:>15}", num, length);
    }
}
