#lang racket

;Structs
(struct foo (bar baz quux) #:transparent)
; foo is name of struct
; bar, baz, quuz are names of fields
; a bunch of functions are added to the environment
;  when you add a struct to the environment
; Similar to a record in ML, but it's MORE

;New functions:
;(foo e1 e2 e3) returns a "foo"
;   with fields bar, baz, and quux holding
;   results of evaluating e1, e2, and e3
;(foo? e) evaluates e and returns #t
;   if the result is something that was made w/ foo function
;(foo-bar e) evaluates e. If result was made with
;   the foo function, returns the contents of bar field (else error)
;(foo-baz e) evaluates e. If result was made with
;   the foo function, returns the contents of baz field (else error)
;(foo-quux e) evaluates e. If result was made with
;   the foo function, returns the contents of quux field (else error)

;Can be used for idioms like our expression example
(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)

;For datatypes like exp, create one struct for each "kind of exp"
; - structs are like ML constructors!
; - but provide constructor, tester, and extractor functions (instead of patterns)
; - dynamic typing means "these are the kinds of exp" is
;   "in comments" rather than a type system
; - dynamic typing means "types" of fields are also "in comments"

(define (eval-exp e)
  (cond [(const? e) e] ; note returning an exp, not a number
        [(negate? e) (const (- (const-int (eval-exp (negate-e e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                    (const (+ v1 v2)))]
        [(multiply? e) (let ([v1 (const-int (eval-exp (multiply-e1 e)))]
                             [v2 (const-int (eval-exp (multiply-e2 e)))])
                         (const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

(define a-test (eval-exp (multiply (negate (add (const 2) (const 2))) (const 7))))

; #:transparent is an optional attribute on struct definitions
; - helps REPL print struct data pretty
; #:mutable is an optional attribute on struct definitions
; - gives you more functions:
;   - set-card-suit! and set-card-rank! for (struct card (suit rank) #:transparent #:mutable)
; - can decide if each struct supports mutation, with usual advantages / disavantages
; - mcons is just a predefined mutable struct!

