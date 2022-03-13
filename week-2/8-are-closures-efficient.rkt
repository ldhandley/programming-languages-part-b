#lang racket

;Is that expensive?
;-Time to build a closure is tiny: a struct with 2 fields
;-Space to store closures MIGHT be large if env is large
;  -But envs are immutable, so natural and correct to have lots of sharing
;  -Still, end up keeping around bindings that are not needed
;-Alternative used in practice: when creating a closure,
; store a possibly-smaller env holding only the variables that
; are free variables in the function body
;  -Free variables: variables that occur, not counting shadowed uses of the same variable name
;  -A function body would never need anything else from the env

;Examples:
;(lambda () (+ x y z)) ;free vars: {x, y, z}
;(lambda (x) (+ x y z)) ;free vars: {y, z}
;(lambda (x y z) (+ x y z)) ;free vars: {}

;So does the interpreter have to analyze code body every time it creates a closure?
;No: before evaluation begins, compute free variables of every function in program and store this information with the function
;Compared to naive store-entire-env approach, building a closure now takes more time but less space
; -And time proportional to number of free vars
; -And various optimizations are possible
;Also we can use a much better data structure for looking up vars than a list