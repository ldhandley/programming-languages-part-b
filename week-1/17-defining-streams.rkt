#lang racket

; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 ...
(define ones (lambda ()
               (cons 1 ones)))
;it's just recursion!

; 1 2 3 4 5 6 7 ...
(define (f x) (cons x (lambda () (f (+ x 1)))))
;(define naturals (lambda () (f 1)))

;better
(define naturals
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; 2 4 6 8 ...
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))

