# CollatzConjecture

## Purpose
This project is a computational exploration of the Collatz Conjecture, a famous unsolved problem in mathematics. The Collatz Conjecture suggests that for any positive integer n, if n is even, divide it by 2, and if n is odd, multiply it by 3 and add 1. Repeating these operations will eventually result in the number 1. While the conjecture has been tested extensively, no general proof has yet been found. This project features 12 distinct implementations of the Collatz Conjecture, including 6 recursive versions, across 6 different programming languages.

The languages included in this project are:
- C#
- Fortran
- Julia
- Lisp
- Python
- Rust

The project is intended to allow comparison of performance and implementation styles across different languages. It also provides recursive and iterative versions of the Collatz Conjecture for deeper computational exploration.

## How to Compile and Run

Below are the instructions for compiling and running the program in each language. Replace 50 and 100 with the desired range of integers to analyze.

### csharp  
	To compile:				mcs collatz.cs -r:System.Numerics.dll
	To run:					mono collatz.exe 50 100

### fortran  
	To compile:				gfortran -o collatz collatz.f90
	To run:					./collatz 50 100

### julia  
	To compile and run:			julia collatz.jl 50 100 

### lisp  
	To compile:				chmod u+x collatz.lisp
	To run:					./collatz.lisp 50 100

### python 
	To compile and run: 			python3 collatz.py 50 100 

### rust
	To compile:				cargo build
	To run: 				cargo run 50 100

## How to Compile and Run: Recursive Versions

In addition to the non-recursive implementations, this project includes recursive versions of the Collatz Conjecture for each language.

### recursedcsharp  
	To compile:				mcs rcollatz.cs -r:System.Numerics.dll
	To run:					mono rcollatz.exe 50 100 

### recursedfortran  
	To compile:                             gfortran -o rcollatz rcollatz.f90
        To run:                                 ./rcollatz 50 100

### recursedjulia  
	To compile and run:                     julia rcollatz.jl 50 100

### recursedlisp  
	To compile:                             chmod u+x rcollatz.lisp
        To run:                                 ./rcollatz.lisp 50 100

### recursedpython  
	To compile and run:                     python3 rcollatz.py 50 100

### recursedrust  
        To compile:                             cargo build
        To run:                                 cargo run 50 100

## License
No license has been provided for this project
