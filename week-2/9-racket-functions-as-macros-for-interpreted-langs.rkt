#lang racket

;Our approach to lang implementation:
; -Implementing lang B in lang A
; -Skipping parsing by writing lang B programs directly in terms of lang A constructors
; -An interpreter written in A recursively evaluates
;What we know about macros
; -Extend the syntax of a lang
; -Use of a macro expands into lang syntax before the program runs (before calling themain interpreter function)

;With our setup, we can use lang A (Racket) functions that
; produce lang B abstract syntax as lang B "macros"
; -Lang B programs can use the macros as though they are part of lang B
; -No change to the interpreter or struct defs
; -Just a programming idiom enabled by our setup
;  -Helps teach what macros are
; -See code from example "macro" defs and "macro" uses
;  -"macro expansion" happens before calling eval-exp

;Hygiene issues with this approach
; -The "macro" approach described here does not deal well with shadowed variables

