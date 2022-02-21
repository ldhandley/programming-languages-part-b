#lang racket

;a cosmetic macro -- adds then, else to if statements
(define-syntax my-if
  (syntax-rules (then else)     ;then, else added as keywords
    [(my-if e1 then e2 else e3) ;this...
     (if e1 e2 e3)]             ;gets replace with this
;   [...] could have other rules for other cases here
    ))
;(my-if foo then bar else baz) -> (if foo bar baz)

;a macro to replace an expression with another one
(define-syntax comment-out
  (syntax-rules ()
    [(comment-out ignore instead) instead]))
;note: no wrapping parens around last instead since that would CALL instead
;(commend-out (car null) (+ 3 4)) -> (+ 3 4)

;A delay macro
;A macro can put an expression under a thunk
; -Delays evaluation without explicit thunk
; -Cannot implement this with a function
;Not client then should not use a thunk (that would double-thunk)
; -Racket's pre-defined delay is a similar macro

(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e)
     (mcons #f (lambda () e))]))

;(f (my-delay e)) ;this will not evaluate e! it turns into an mcons that thunks e

;Best to keep my-force as a macro
;If you did expand it with a macro instead, you'd re-evaluate argument e multiple times:
(define-syntax my-force-macro1
  (syntax-rules ()
    [(my-force e) ;re-evals e
     (if (mcar e) ;re-evals e
         (mcdr e) ;re-evals e
         (begin (set-mcar! e #t) ;...
                (set-mcdr! e ((mcdr e))) ;...
                (mcdr e)))])) ;...

;If we wanted to fix this, we could:
(define-syntax my-force-macro1
  (syntax-rules ()
    [(my-force e)
     (let ([x e]) ;creates local variable for e (evals only once)
       (if (mcar x) 
           (mcdr x) 
           (begin (set-mcar! x #t) 
                  (set-mcdr! x ((mcdr x))) 
                  (mcdr x))))])) 
;But this really isn't a situation where we should use a macro
;Using a macro just to have the exact same semantics as a function serves no purpose