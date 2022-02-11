#lang racket

; empty list:          null
; cons constructor:    cons
; access head of list: car (name based on historical accident)
; access tail of list: cdr (name based on historical accident)
; check for empty:     null? (can pronounce null-huh)
; (list e1 e2 ... en) for building lists

;sum all #'s in a list
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

;append
(define (my-append xs ys) ;hyphens are convention for naming in racket
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

;map
(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs))
            (my-map f (cdr xs)))))

