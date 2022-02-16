#lang racket

;Racket has mutation (assignment statements)
;only use this when APPROPRIATE
; (set! x e)
;for the x in the current environment, subsequent
; lookups of x get the result of evaluating expression e
;  - any code using this x will be affected
;  - like x = e in Java, C, Python (etc)
;once you have side-effects, sequences are useful:
; (begin e1 e2 ... en)
; -this lets you do the expressions in order
; -result is whatever final en evaluates to

(define b 3)
(define f (lambda (x) (* 1 (+ x b)))) ; lexical scope will look up what the current contents of b are
(define c (+ b 4)) ;7
(set! b 5)
(define z (f 4))   ;9 (function f uses new b)
(define w c)       ;7 (c does not update after its initial definition)
;environment for closure determined when function is
;  defined, but body is evaluated when function is
;  called.
;once an expression produces a value (like c above), it
;  is irrelevant how the value produced
;mutating top-level definitions is particularly problematic
;  - what if any code could do set! on anything?
;  - how could we defend against it?
;general principal: if something you need not to change
; might change, make a local copy of it. Example:
;(define b 3)
;(define f
;  (let ([b b])
;    (lambda (x) (* 1 (+ x b)))))
; could use a different name for local copy but do not need to

;But aren't primitives like + and * really just
;  predefined variables bound to functions?
;That means they are mutable too
;Example:
;(define f
;  (let ([b b]
;        [+ +]
;        [* *])
;    (lambda (x) (* 1 (+ x b)))))
;even that won't work if f uses other functions that
;  use things that might get mutated - all functions
;  would need to copy everything mutable they used!

;The Racket designers decided that that was just too
;  much though. So you don't have to program like this:
;  - each file is a module
;  - if a module does not use set! on a top-level
;    variable, then Racket makes it constant and
;    forbids set! outside the module
;  - primitives like +, *, and cons are in a module that
;    does not mutate them
;Racket makes that reasonable compromise about what
;  you're able to set! and what you're not. Otherwise,
;  mutation of top-level bindings is a really dangerous
;  thing. 