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
    let mut top_results: Vec<(u64, u32)> = Vec::new();

    for num in start..=end {
        let length = collatz_length(num);
        // Check if we already have this length
        if let Some(pos) = top_results.iter().position(|&(_, l)| l == length) {
            if num < top_results[pos].0 {
                top_results[pos] = (num, length);
            }
        } else {
            // New length
            if top_results.len() < 10 {
                top_results.push((num, length));
            } else {
                let mut min_index = 0;
                for i in 1..top_results.len() {
                    let (num_i, len_i) = top_results[i];
                    let (num_min, len_min) = top_results[min_index];
                    if len_i < len_min || (len_i == len_min && num_i > num_min) {
                        min_index = i;
                    }
                }

                let (min_num, min_len) = top_results[min_index];
                if length > min_len || (length == min_len && num < min_num) {
                    top_results[min_index] = (num, length);
                }
            }
        }
    }

    // Sort by sequence length descending, then number ascending
    top_results.sort_unstable_by(|a, b| {
        b.1.cmp(&a.1).then_with(|| a.0.cmp(&b.0))
    });

    top_results
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
