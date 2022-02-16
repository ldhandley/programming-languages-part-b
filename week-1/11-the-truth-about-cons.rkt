#lang racket

;cons just makes a pair
;  - often called a cons cell
;  - by convention and standard library, lists are
;    nested pairs that eventually end with null
(define pr (cons 1 (cons #t "hi"))) ; not a list
(define lst (cons 1 (cons #t (cons "hi" null)))) ; this is a list, ends in null
(define hi (cdr (cdr pr)))
(define hi-again (cdr (cdr lst)))

;why allow improper lists?
;  - pairs are useful
;style:
;  - use proper lists for collections of unknown size
;  - but feel free to use cons to build a pair (we'll see structs may be better)
;built-in primitives:
;  - list? returns #t for proper lists, including empty list
;  - pair? returns true for things made by cons
;    - all improper & proper lists except the empty list 