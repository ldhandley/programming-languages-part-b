
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;calls next-in-sequence
(define (sequence low high stride)
  (cond [(< high low) null]
        [(>= high low) (cons low
                             (sequence (+ low stride) high stride))]))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (letrec ([get-ith (lambda (xs n i) (if (= i n)
                                         (car xs)
                                         (get-ith (list-tail xs 1) (+ n 1) i)))])
  (cond [(< n 0 ) (error "list-nth-mod: negative number")]
        [(= (length xs) 0) (error "list-nth-mod: empty list")]
        [#t (get-ith xs 0 (remainder n (length xs)))])))

;returns the first n elements in a list from the stream
;assume n is non-negative
(define (stream-for-n-steps s n)
  (letrec ([add-to-list (lambda (s n l) (if (= n 0)
                                        l
                                        (add-to-list ((cdr s)) (- n 1) (append l (list (car s))))))])
    (add-to-list (s) n '())))