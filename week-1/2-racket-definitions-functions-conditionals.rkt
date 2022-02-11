#lang racket

(define x 3)
(define y (+ x 2)) ; + is a function, this is a call

(define cube1
  (lambda (x)
    (* x (* x x)))) ; labmda is an anonymous function (like fn in SML)

(define cube2
  (lambda (x)
    (* x x x))) ; in racket, some functions can really take any number
                ; of arguments! it's not syntactic sugar for tupling or anything

(define (cube3 x)
  (* x x x))    ; this syntax IS syntactic sugar for the previous example
                ; this creates a variable cube3 that's bound to a function
                ; that takes 1 argument and has (* x x x) as its body


(define (pow1 x y)
  (if (= y 0)                   ; if e1 e2 e3
      1
      (* x (pow1 x (- y 1)))))

(define pow2          ;this is the curried version of the previous version
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

(define three-to-the (pow2 3))  ;partial application of a curried function

(define sixteen ((pow2 4) 2)) ;note the parentheses! different than you might
                              ;expect. ((pow2 4) 2) calls the partial application
                              ;with the final argument. there is no syntactic
                              ;sugar that simplifies this

