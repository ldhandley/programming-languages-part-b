
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;calls next-in-sequence
(define (sequence low high stride)
  (cond [(< high low) null]
        [(>= high low) (cons low
                             (sequence (+ low stride) high stride))]))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
  (letrec ([get-ith (lambda (xs n i) (if (= i n)
                                         (car xs)
                                         (get-ith (list-tail xs 1) (+ n 1) i)))])
  (cond [(< n 0 ) (error "list-nth-mod: negative number")]
        [(= (length xs) 0) (error "list-nth-mod: empty list")]
        [#t (get-ith xs 0 (remainder n (length xs)))])))

;returns the first n elements in a list from the stream
;assume n is non-negative
(define (stream-for-n-steps s n)
  (letrec ([add-to-list (lambda (s n l) (if (= n 0)
                                        l
                                        (add-to-list ((cdr s)) (- n 1) (append l (list (car s))))))])
    (add-to-list (s) n '())))

(define (funny-number-stream-helper x)
  (lambda () (cons x (funny-number-stream-helper (cond [(< x 0) ;if the current x is negative, we want to make it positive and add 1 
                                                        (+ (- x) 1)]
                                                       [(= (remainder (+ x 1) 5) 0) ;if the next x (current x + 1) is divisible by 5, make it negative
                                                        (- (+ x 1))]
                                                       [#t ;otherwise, just add 1 to get the next x
                                                        (+ x 1)]))))) 
(define funny-number-stream (funny-number-stream-helper 1))

;put helper function inside letrec this time... better style? I feel like it's harder to read, personally...
(define dan-then-dog (letrec ([dan-then-dog-helper (lambda (x)
                                                     (lambda () (cons x (dan-then-dog-helper (cond [(equal? x "dan.jpg") "dog.jpg"]
                                                                                                   [(equal? x "dog.jpg") "dan.jpg"])))))])
                       (dan-then-dog-helper "dan.jpg")))

(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s)))
                   (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
  (letrec ([cycle-helper (lambda (n)
                           (cons (cons (list-nth-mod xs n)
                                       (list-nth-mod ys n))
                                 (lambda () (cycle-helper (+ n 1)))))])
    (lambda () (cycle-helper 0))))

(define (vector-assoc v vec)
  (letrec ([vector-assoc-helper
         (lambda (pos)
           (cond [(>= pos (vector-length vec)) #f]
                 [(or (not (pair? (vector-ref vec pos)))
                      (equal? (cdr (vector-ref vec pos)) null)) ;need this b/c list of length 1 is also a pair
                  (vector-assoc-helper (+ pos 1))]
                 [(not (equal? (car (vector-ref vec pos)) v))
                  (vector-assoc-helper (+ pos 1))]
                 [(equal? (car (vector-ref vec pos)) v)
                  (vector-ref vec pos)]))])
    (if (not (vector? vec)) #f (vector-assoc-helper 0))))

