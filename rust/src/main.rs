use std::env;
use std::collections::HashSet;

// Function to calculate the length of the Collatz sequence for a given number `n`
fn collatz_length(mut n: u64) -> u32 {
    let mut length = 0;
    while n != 1 { 
        if n % 2 == 0 {
            n /= 2;
        } else {
            n = 3 * n + 1;
        }
        length += 1;
    }
    length
}

// Function to find the top 10 numbers with the longest Collatz sequences in the range
fn find_top_10_collatz_numbers(start: u64, end: u64) -> Vec<(u64, u32)> {
    let mut collatz_list = Vec::new();  // List to store (sequence length, number)
    for num in start..=end {
        let length = collatz_length(num);
        collatz_list.push((length, num));   // add to list 
    }

    // Sort the list by sequence length descending, then by number ascending
    collatz_list.sort_unstable_by(|a, b| {
        b.0.cmp(&a.0).then_with(|| a.1.cmp(&b.1))
    });

    // List to store the top 10 results
    let mut top_combined = Vec::new();
    // Set to track unique sequence lengths
    let mut seen_lengths = HashSet::new();
    
    for (length, num) in collatz_list {
        if !seen_lengths.contains(&length) {    // checks if sequence length is unique  
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

    // Parse args 
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
