#lang racket

;You shouldn't use macros for a function like this, but it's
; a short example for our purposes:
(define-syntax dbl1 (syntax-rules () [(dbl x) (+ x x)]))
(define-syntax dbl2 (syntax-rules () [(dbl x) (* 2 x)]))
; -These 2 macros are not equivalent to each other (unlike the functions they represent)
; -Consider: (double (begin (print "hi") 42))
;Can use a local binding to avoid re-evaluation:
(define-syntax dbl3
  (syntax-rules ()
    [(dbl x) (let ([y x]) (+ y y))]))
;Also good style for macros not to have surprising evaluation order
; -Good rule of thumb to preserve left-to-right
; -Bad example (fix with local binding):
(define-syntax take
  (syntax-rules (from)
    [(take e1 from e2)
     (- e2 e1)]))
;this could be confusing for a user because it evaluates the args
; in the opposite order! (e2, then e1). Could fix this with local
; variable def in a let expression

(define-syntax dbl4
  (syntax-rules ()
    [(dbl x) (let ([y 1])
               (* 2 x y))]))
;use: (let ([y 7]) (dbl4 y))
;naive expansion (which often happens in other langs):
;  (let ([y 7]) (let ([y 1]) (* 2 y y)))
;Racket has hygiene though: keeps local variables in macro
; separate from any local variables in scope where you're using
; the macro - changes the names of variables inside of macros
; (don't worry how exactly it does this, but it does)

(define-syntax dbl5
  (syntax-rules ()
    [(dbl x) (* 2 x)]))
;use: (let ([* +] (dbl 42))) ;* is being shadowed by +
;naive expansion: (let ([* +] (* 2 42)))
;Racket gets this right though! You look * up in the environment
; where the macro was defined, not the environment where the
; macro was used
;Racket's lexical scoping & hygiene in its macro system is
; way better than others!

;A hygienic macros system:
; 1. Secretly renames local variables in macros with fresh names
; 2. Looks up variables used in macros where the macro is defined

;Neither of these rules are followed by the "naive expansion"
; most macros systems use
; -Without hygiene, macros are much more brittle (non-modular)
;On rare occasions, hygiene is not what you want
; -Racket has somewhat complicated support for that