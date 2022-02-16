#lang racket

;A stream is an infinite sequence of values
; -So cannot make a stream by making all the values
; -Key idea: Use a thunk to delay creating most of the sequence
; -Just a programming idiom

;A powerful concept for division of labor:
; -Stream producer knows how to create any number of values
; -Stream consumer decides how many values to ask for

;Some examples of streams you might (not) be familiar with:
; -User actions (mouse clicks, etc.)
; -UNIX pipes: cmd1 | cmd2 has cm2 "pull" data from cmd1
;   the 2nd command views the first command as a stream!
; -Output values from a sequential feedback circuit (electrical engineering)

;Represent streams with pairs and thunks
;Let a stream be a thunk that when called returns a pair:
;  '(next-answer . next-thunk)
;       next-thunk is the stream for the 2nd-answer thru infinity

