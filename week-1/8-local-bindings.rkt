#lang racket

; let expression lets us do local bindings
; let ([x1 e1]
;      [x2 e2]
;       ...
;      [xn en]
;  body)

(define (max-of-list xs)
  (cond [(null? xs) (error "max-of-list given empty list")]
        [(null? (cdr xs)) (car xs)]
        [#t (let ([tlans (max-of-list (cdr xs))])
              (if (> tlans (car xs))
                  tlans
                  (car xs)))]))

;4 different ways to define local variables in Racket:
; let
; let*
; letrec
; define
;Variety is good: they have different semantics
;  Choose the one most convenient for your needs,
;  which helps communicate your intent to people
;  reading your code

;let expression: expressions are all evaluated
;in the environment from before the let-expressions
;e.g. one local variable can not use another
;  local variable
; This is very different from ML!

;let* expression is pretty much ML's let expression
;expressions are evaluated in the environment produced
;from the previous bindings.
;Can repeat bindings (they'll shadow earlier bindings)

;letrec expressions are evaluated in the environment
;that includes all bindings.
; This is necessary for mutual recursion!
;but expressions are still evaluated in order, and
;accessing an uninitialized binding would produce
;an error
;e.g. this throws an error b/c z is accessed before def:
(define (bad-letrec x)
  (letrec ([y z]
           [z 13])
    (if x y z)))

; in certain positions, like beginning of
; function bodies, you can put defines
;  - for defining local variables, same semantics as
;    letrec
