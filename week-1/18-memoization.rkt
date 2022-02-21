#lang racket

;If a function has no side effects and does not read mutable
; memory, no point in computing it twice for the same args
;  -Can keep a cache of previous results
;  -Net win if (1) maintaining cache is cheaper than
;   recomputing and (2) cached results are reused

;Similar to promises, but if the function takes arguments, then
; there are multiple "previous results"

;For recursive functions, this memoization can lead to
;exponentially faster programs
;  -Related to algorithmic tecnique of dynamics programming

;This is a bad implementation of the fib function. Quickly
; takes a crazy amount of time to compute next fib #.
(define (fibonacci1 x)
  (if (or (= x 1) (= x 2))
      1
      (+ (fibonacci1 (- x 1))
         (fibonacci1 (- x 2)))))

(define fibonacci3
  (letrec([memo null]
          [f (lambda (x)
               (let ([ans (assoc x memo)])
                 (if ans
                     (cdr ans)
                     (let ([new-ans (if (or (= x 1) (= x 2))
                                        1
                                        (+ (f (- x 1))
                                           (f (- x 2))))])
                       (begin
                         (set! memo (cons (cons x new-ans) memo))
                         new-ans)))))])
    f))