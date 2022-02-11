#lang racket

; Racket syntax is very simple:
; A "term" (anything in language) is either
; - An "atom": e.g. #t, #f, 34, "hi", null, 4.0, x, ...
; - A "special form": e.g. define, lambda, if, ...
; - A "sequence" of terms in parens: (t1 t2 ... tn)
;   - If t1 a special form, semantics of sequence is special
;   - Else it's a function call!

; [ is equivalent to (, but you just have to match them with ]

; By parenthesizing everything, converting program text into a tree
; representing the program (parsing) is trivial and unambiguous
; - Atoms are leaves
; - Sequences are nodes with elements as children
; - (No other rules)
; Also makes indentation easy
; No need to worry about operator precendence

