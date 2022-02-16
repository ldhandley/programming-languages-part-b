#lang racket

;bindings in a file work like local defines
; - like ML, you can refer to earlier bindings
; - unlike ML, you can also refer to later bindings
; - but refer to later bindings only in function bodies
;   - why? because bindings are evaluated in order
;   - and function bodies aren't evaluated until
;     they are called
;   - you would get an error for an undefined variable
; - unlike ML, cannot define the same variable
;   twice in a module
;    - would make no sense: cannot have both in env

(define (f x) (+ x (* x b))) ;forward ref ok here!
(define b 3)
(define c (+ b 4)) ;backward ref ok too (just like ML)
;(define d (+ e 4)) ;not ok, get error
(define e 5)
;(define f 17) ;not ok, f is already defined in this module

;REPL doesn't work completely properly
; normally does what you want... but there can be
; issues if you try to shadow something that has
; been previously defined.
; therefore, avoid recursive function defs or
; forward references in REPL

;in Racket, every file is implicitly a module
;  (so bindings are not really top-level)
;a module can shadow bindings from other modules
;  it uses (including Racket standard library)
;so we could redefine + or any function (but this
;  is poor style)