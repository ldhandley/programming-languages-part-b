#lang racket

; cond is better style than nested if statements
; (cond [e1a e1b] [e2a e2b] ... [eNa eNb])
; first expression in each pair is the test, 2nd is what to do if that
;   test was true
; remember, brackets or parens don't matter; this just looks cleaner
; Good style: eNa should be #t (e.g. in ANY OTHER CASE, use this
;   final expression, eNb)
(define ys (list (list 4 (list 5 0)) 6 7 (list 8) 9 2 3 (list 0 1)))
(define zs (list (list "foo") (list 5 0) 6 7 (list 8) 9 2 3 (list 0 1)))

; compare to code from last video, much cleaner here!
(define (sum3 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum3 (cdr xs)))]
        [(list? (car xs)) (+ (sum3 (car xs)) (sum3 (cdr xs)))]
        [#t (sum3 (cdr xs))]))

; For both if and cond, test expression can evaluate to anything!
;   it's not an error if the result is not #t or #f!
; Semantics for if and cond:
;   treat anything other than #f as true!
;   in some languages, other things are false (but not in Racket)
; This feature makes no sense in a statically typed language
; Some consider using this feature poor style, but it can be convenient!

(define (count-falses xs)
  (cond [(null? xs) 0]
        [(car xs) (count-falses (cdr xs))]
        [#t (+ 1 (co:wunt-falses (cdr xs)))]))