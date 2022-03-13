#lang racket

;Racket has nothing like datatype binding for one-of types

;No need in a dynamically typed language:
; - Can just mix values of diff types
;   and use primitives like number?,
;   string?, pair? to "see what we have"
; - Can use cons cells to build up any kind of data

;This segment: coding up datatypes with what we already know

;Next segment: Better approach for the same thing with structs
; - Contrast helps explain advantages of structs

;In ML, cannot have a list of "ints or strings" so use a datatype:
;  datatype int_or_string = I of int | S of string
;In Racket, dynamic typing makes this natural without explicit tags
; - Instead, every value has a tag with primitives to check it
; - So just check car of list with number? or string?

;note: arguably bad style to not have else clause
(define (funny-sum xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (funny-sum (cdr xs)))]
        [(string? (car xs)) (+ (string-length (car xs))
                               (funny-sum (cdr xs)))]))



; just helper functions that make lists where first element is a symbol


; Note: More robust could check at run-time the type of thing being put in
(define (Const i) (list 'Const i))
(define (Negate e) (list 'Negate e))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2) (list 'Multiply e1 e2))

; just helper functions that test what "kind of exp"
; Note: More robust could raise better errors for non-exp values
(define (Const? x) (eq? (car x) 'Const))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply))

; just helper functions that get the pieces for "one kind of exp"
; Note: More robust could check "what kind of exp"
(define (Const-int e) (car (cdr e)))
(define (Negate-e e) (car (cdr e)))
(define (Add-e1 e) (car (cdr e)))
(define (Add-e2 e) (car (cdr (cdr e))))
(define (Multiply-e1 e) (car (cdr e)))
(define (Multiply-e2 e) (car (cdr (cdr e))))

; fyi: there are built-in functions for getting 2nd, 3rd list elements that would
; have made the above simpler:
;(define Const-int cadr)
;(define Negate-e cadr)
;(define Add-e1 cadr)
;(define Add-e2 caddr)
;(define Multiply-e1 cadr)
;(define Multiply-e2 caddr)

; same recursive structure as we have in ML, just without pattern-matching
; And one change from what we did before: returning an exp, in particular
; a Constant, rather than an int
(define (eval-exp e)
  (cond [(Const? e) e] ; note returning an exp, not a number
        [(Negate? e) (Const (- (Const-int (eval-exp (Negate-e e)))))]
        [(Add? e) (let ([v1 (Const-int (eval-exp (Add-e1 e)))]
                        [v2 (Const-int (eval-exp (Add-e2 e)))])
                    (Const (+ v1 v2)))]
        [(Multiply? e) (let ([v1 (Const-int (eval-exp (Multiply-e1 e)))]
                             [v2 (Const-int (eval-exp (Multiply-e2 e)))])
                         (Const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

(define a-test (eval-exp (Multiply (Negate (Add (Const 2) (Const 2))) (Const 7))))

; We defined our own constructor, test-variant, extract-data functions
; Same recursive structure, but without pattern matching
; With no type system, there is no notion of "what is an exp"
;  except in documentation

;Symbols
; - Start with a quote
; - Like strings, acn be almost any character sequence
; - Unlike strings, compare two symbols with eq? which is fast
