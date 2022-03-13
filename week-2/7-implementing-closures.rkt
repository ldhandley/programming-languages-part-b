#lang racket

;Most interesting & mind-bending part of HW
; -with lexical scope

;The interpreter uses a closure data structure (with 2 parts)
; to keep the env it will need to use later:
; (struct closure (env fun) #:transparent)
;Evaluate a function expression:
; -A function is NOT a value; a closure IS a value
;  -Evaluating a function returns a closure
; -Create a closure out of (a) the function and (b) the current
;  env when the function was evaluated
;Evaluate a function call:
; (call e1 e2) ;e1 is closure to call and e2 is argument
; -Use current env to evaluate e1 to a closure
;  -Error if result is a value that is not a closure
; -Use current env to evaluate e2 to a value
; -Evaluate closure's function body in the closure's env, extended to:
;  -Map the function's argument-name to the argument-value
;  -And for recursion, map the function's name to the whole closure
;This is the same semantics we learned a few weeks ago
;Given the closure, the code part is only ever evaluated using the
; env part (extended), not the env at the call-site
