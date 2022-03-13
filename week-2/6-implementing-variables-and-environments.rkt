#lang racket

;Interpreters so far have been for langs without variables
; -No let-expressions, functions-with-arguments, etc.
; -Lang in hw has all these things
;This segment describes in English what to do
; -Up to you to translate this into code
;Fortunately, what you have to implement is what we have been
; stressing since the very, very beginning of the course

;An environment is a mapping from variables (Racket strings) to values (as defined by the lang)
; -Only ever put pairs of strings and values in the env
;Evaluation takes place in env
; -Env passed as an argument to interpreter helper function
; -A variable expression looks up the variable in the env
; -Most subexpressions use same env as outer expression
; -A let-expression evaluates its body in a larger env

;So now a recursive helper function has all the interesting stuff:
; (define (eval-under-env e env)
;   (cond ...)) ;case for each kind of expression
; -Recursive calls must "pass down" correct environment
;Then eval-exp just calls eval-under-env with same expression and the empty env
;On HW, environments themselves are just Racket lists containing Racket pairs of
; a string and a MUPL value

;For HW, make sure eval-under-env is top-level (not a locally defined helper function inside of eval-exp)
; -They're going to test eval-under-env directly, so it needs to be top-level

