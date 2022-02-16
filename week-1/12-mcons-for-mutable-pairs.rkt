#lang racket

;cons cells are immutable in Racket
;  - this was a major change from Scheme/Lisp
;  - this makes list aliasing irrelevant (since list can never change)
;  - implementation can make list? fast, since listness is determined when cons cell is created

;set! really doesn't mutate cons cells
(define x (cons 14 null))
(define y x)
(set! x (cons 42 null)) ; x is now bound to '(42), while y is still bound to '(14)
; set! changed x, but did not change the cons cell that x refers to

;but what if you want to change the contents of the
;  cons cell, Racket has you covered
(define mpr (mcons 1 (mcons #t "hi")))
;use mcar and mcdr to access head and tail
;use set-mcdr! to change the value of cdr
;use set-mcar! to change the value of car
(set-mcdr! mpr 47)
;use mpair? to see if you have a mcons list
;note: length requires a proper list. Can't use on mcons that look like proper lists.
