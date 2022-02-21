
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

