#lang racket

;For each language construct, the semantics specifies
; when subexpressions get evaluated. In ML, Racket, Java, C:
;  - Function arguments are eager (call-by-value)
;    - Evaluated once before calling the function
;  - Conditional branches are not eager
;It matters: calling factorial-bad never terminates:
(define (my-if-bad x y z)
  (if x y z))

(define (factorial-bad n)
  (my-if-bad (= n 0)
             1
             (* n (factorial-bad (- n 1)))))
;the last parameter to my-if-bad is evaluated immediately,
;  which starts a recursive call to factorial-bad, which
;  never terminates

;how can we get around this?

;e2 and e3 should be zero-argument functions (delays evaluation)
(define (my-if-strange-but-works e1 e2 e3)
  (if e1 (e2) (e3)))

(define (factorial-okay x)
  (my-if-strange-but-works
   (= x 0)
   (lambda () 1)
   (lambda () (* x (factorial-okay (- x 1))))))
;functions do not evaluate their bodies until you
; call them, so all 3 arguments to my-if-strange-but-works
; evaluate very quickly. We only evaluate call dependent
; on the if branch here!

;we know how to delay evaluation: put expression in a
;  function and don't call the function yet
;  - thanks to closures, can use all the same vars later
;a zero-argument functions used to delay evaluation
;  is called a thunk
;  - as a verb: thunk the expression