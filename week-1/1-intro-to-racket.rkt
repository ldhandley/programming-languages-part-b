#lang racket

;In Racket's module system, every file is module so
; everything is private from other files. You have to
; provide whatever you want to provide other files.
(provide (all-defined-out))

;Racket comments

;Basic definition:
(define s "hello")

;after pressing run, try typing "s" in the REPL