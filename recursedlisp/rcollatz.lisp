#!/usr2/local/sbcl/bin/sbcl --script

;; Recursive function to calculate the length of the Collatz sequence for a given number `n`
(defun collatz-length (n)
	(if (= n 1)	;; base case 
      		0
      	(+ 1 (collatz-length (if (evenp n)
        	(/ n 2)
        (+ (* 3 n) 1))))))

;; Function to find the top 10 numbers with the longest Collatz sequences in a given range
(defun find-top-10-collatz-numbers (start end)
	(let ((collatz-list '()))			;; empty list to store results
    	(loop for num from start to end do
        	(let ((length (collatz-length num)))
            	(push (list length num) collatz-list)))

	;; Sort the list by sequence length descending, then by number ascending
    	(setf collatz-list
        (sort collatz-list
        	(lambda (a b)
                (or (> (first a) (first b))
                	(and (= (first a) (first b))
                        (< (second a) (second b)))))))
    
	(let ((top-10 '())			;; List to store the top 10 results
        (seen-lengths (make-hash-table)))	;; Hash table to track unique lengths
      
	(loop for item in collatz-list do
        (let ((length (first item))
        (num (second item)))
        	(unless (gethash length seen-lengths)	;; checks if sequence length is unique 
                	(push (list num length) top-10)
                	(setf (gethash length seen-lengths) t)))
        	(when (= (length top-10) 10)
              		(return)))
      	(reverse top-10))))

;; main method to handle overall program flow
(defun main ()
  	(let ((args (cdr *posix-argv*)))
    	(if (/= (length args) 2)
        	(progn
          	(format t "Usage: collatz <start> <end>~%")
          	(quit))
        
	(let ((start (parse-integer (first args) :junk-allowed t))
        (end (parse-integer (second args) :junk-allowed t)))
        
	(if (or (null start) (null end))
              	(progn
                (format t "Error: Start and end values must be integers.~%")
                (quit))
        
	(if (> start end)
        	(progn
                (format t "Error: Start value must be less than or equal to end value.~%")
                (quit))
        
	(let ((top-10 (find-top-10-collatz-numbers start end)))
        (format t "Sorted based on sequence length~%")
        (loop for item in top-10 do
        	(format t "~10d~10d~%" (first item) (second item)))
        (format t "~%Sorted based on integer size~%")
        	(setf top-10
                	(sort top-10
                        (lambda (a b)
                        (> (first a) (first b)))))
        (loop for item in top-10 do
        	(format t "~10d~10d~%" (first item) (second item))))))))))

(main)

