#lang racket

;thunks let you skip an expensive computation if you don't need it
;great if you take the true branch:
;(define (f th)
;  (if (...) 0 (... (th) ...)))
;but worse if you end up using the thunk more than once:
;(define (f th)
;  (... (if (...) 0 (... (th) ...))
;       (if (...) 0 (... (th) ...))
;       (if (...) 0 (... (th) ...))))
; you might have to evaluate th multiple times!
; or not at all. WHAT TO DO?

; this is a silly addition function that purposely runs slows for 
; demonstration purposes
(define (slow-add x y)
  (letrec ([slow-id (lambda (y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))

; multiplies x and result of y-thunk, calling y-thunk x times
(define (my-mult x y-thunk) ;; assumes x is >= 0
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))
;fast for 0, but increasingly slower as x increases

;assuming some expensive computation has no side effects,
;  ideally we would:
;  - Not compute it until needed
;  - Remember the answer so future uses complete
;    immediately (called lazy evaluation)
;languages where most constructs, including function args,
;  work this way are lazy languages
;  - Haskell
;We're going to code this up in Racket!
;Racket predefines support for promises, but we can make
;  our own
;  - thunks and mutable pairs are enough