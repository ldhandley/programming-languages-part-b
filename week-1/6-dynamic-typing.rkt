#lang racket

; Frustrating that you can't catch "little errors" like (n * x) until you 
;   test your function. Testing becomes more important
; But you can use very flexible data structures and code without
;   having to convince a type checker that it makes sense
; Example: what if you wrote a sum function that could sum list of nested
;   numbers, any amount of nesting
;   - Can't do this in ML without creating a datatype bindings and a constructor
;   - In Racket, we'll just be able to do this

(define xs (list 4 5 6))
(define ys (list (list 4 (list 5 0)) 6 7 (list 8) 9 2 3 (list 0 1)))

(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum1 (cdr xs)))
          (+ (sum1 (car xs)) (sum1 (cdr xs))))))

; This won't work if you have something in your list that's not a # or list

(define (sum2 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum2 (cdr xs)))
          (if (list? (car xs))
              (+ (sum2 (car xs)) (sum2 (cdr xs)))
              (sum2 (cdr xs))))))

;This works even if there's something other than a # or list in list
