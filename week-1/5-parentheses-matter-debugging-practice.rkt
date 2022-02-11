#lang racket

; Parentheses MATTER. In other languages, parentheses are sometimes optional
;  or maybe as you're tinkering with your code, you find that parens
;  adding parens might fix an issue you're having (feels a little arbitrary)
; In Racket, do not add or remove parens because you feel like it!
; In most places, (e) means call e with zero arguments.
; So ((e)) means call e with zero arguments and calll the result
;  with zero arguments

(define (fact n) (if (= n 0) 1 (* n (fact (- n 1)))))

;ERROR: expected a procedure that can be applied to arguments
; 1 should not be in parentheses. It's trying to call it like a function
(define (fact1 n) (if (= n 0) (1) (* n (fact1 (- n 1)))))

