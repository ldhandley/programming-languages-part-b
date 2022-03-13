#lang racket

;Struct definitions are NOT syntactic sugar for the
;  approach we used before with lists.
;Structs are not just lists!
;Each struct definition adds a new kind of primitive data!
;So calling car, cdr, or mult-e1 on "an add" is a run-time error

;List approach is error-prone
; -Can break abstraction by using car, cdr, and
;  list library functions directly on "add expressions"
;  -e.g. you can call Multiply-e1 on an "add expression" since it just boils down to car & cdr's

;Struct approach advantages
; -Better style, more concise for defining data types
; -About equally convenient for using data types
; -But much better at timely errors when misusing data types
;  -Cannot use accessor functions on wrong kind of data
;  -Cannot confuse tester functions

;Struct approach is even better combined with other Racket features
;  not discussed here:
; -Module system lets us hide the constructor function to enforce invariants
;  -List-approach cannot hide cons from clients
;  -Dynamically-typed languages can have abstract types by letting modules define new types!
; -Contract system lets us check invariants even if constructor is exposed
;  -E.g. fields of an "add" must also be "expressions"

;Struct is special
;Often we end up learning that some convenient feature could be coded up with other features
;Not so with struct definitions:
; -A function cannot introduce multiple bindings (you couldn't do what we're doing with structs using functions!)
; -Neither functions nor macros can create a new kind of data
;  -Result of constructor function returns #f for every other tester function:
;   number?,pair?,other structs' tester functions, etc.