#lang racket

;Typical workflow for implementing a programming lang
;Contents of code file is passed in as a string (concrete syntax) to the parser
;Parser gives us syntax error messages - tells you if a paren is in the wrong place
;If no syntax errors, output of parser is a syntax tree (abstract syntax)
  ;This is the structure of the program that's implemented
;Lang might have a type checker next (throws type errors)
;If no type errors, pass along to the "rest of the implementation" which evaluates and comes up with an answer

;Interpreter or compiler (the rest of the implementation)
;This takes AST (abstract syntax tree) and "runs the program" to produce result
;2 approaches to implement PL B:
; -Write an interpreter in another language A
;   -Better names: evaluator, executor
;   -Take a program in B and produce an answer (in B)
; -Write a compiler in another language A to a third language C
;   -Better name: translator
;   -Translation must preserve meaning (equivalence)
;We call A the metalanguage
; -Crucial to keep A (lang used to implement lang) & B (lang being implemented) straight

;In modern practice, you often have both an interpreter & compiler and multiple layers
;Example:
; -Java compiler to bytecode intermediate lang
; -Interpreter for bytecode (itself in binary), but compile frequent functions to binary at run-time
; -The chip is itself an interpreter for binary
;  -Except x86 has a translator in hardware to more primitive micro-operations it then executes
;Racket uses a similar mix of interpreters & compilers

;Interpreter vs compiler vs combinations is about a particular lang
; implementation, not the lang definition
;There is NO such thing as a "compiled language" or an "interpreted language"
; -Programs cannot "see" how the implementation works
;Unfortunately, you often hear phrases like
; -"C is faster because it's compiled and LISP is interpreted"
; -This is nonsense

;If implementing PL B in PL A, we can skip parsing
; -Have B programmers write ASTs directly in PL A
; -Not so bad with ML constructors or Racket strucs
; -Embeds B programs as trees in A

;Let metalang A = Racket
;Let language-implemented B = "Arithmetic language"
;Arithmetic programs written with calls to Racket constructors
;The interpreter is eval-exp!