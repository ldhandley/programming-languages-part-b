#lang racket

;Tokens are essentially words.
;Macro systems generally work at the level of tokens, not
; sequences of characters
; -So must know how programming languages tokenizes text

;Example: macro that expands head to car
; -Would not rewrite (+ headt foo) to (+ cart foo)
; -Would not rewrite head-door to car-door
;  -But would in C where head-door is subtraction

;Second question for macro system: how does associativity work?
;In C/C++ you define a macro like this:
; #define ADD(x,y) x+y
;If you have a program with ADD(1,2/3)*4, this actually means
; 1+2/3*4, NOT (1+2/3)*4. So C macro writers have to use lots
; of parentheses: #define ADD(x,y) ((x)+(y))
;Racket doesn't have this problem:
; -Macro use: (macro-name ...)
; -After expansion: (something else in same parens)

;Third question for macro system: can variables shadow macros?
;Racket doesn't work like this, but you could imagine a
; macro system where macros also apply to variable bindings:
;(let ([head 0][car 1]) head) ;0
;(let* ([head 0][car 1]) head) ;0
;These would become:
;(let ([car 0][car 1]) car) ;error
;(let* ([car 0][car 1]) car) ;1
;This is why in C/C++ convention is all-caps macros and non- all-caps everything else
;Racket does NOT work this way - it gets scope "right"

