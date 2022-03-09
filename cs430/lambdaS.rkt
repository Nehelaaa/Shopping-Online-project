#lang racket
;SEMANTICS OF lambdaS
;eval(ef) = (lambda(x)eb);if function, reutrn lambda x and the the body(eb) ;ef = the function of e; eb is the function body
;eval(ea)= va ;if a variable, return a value ;ea is the argument of e, va is valueof a
;eval(subst(eb,x,va)= vb ;in the function body, replace every instance of x with the value va, evaluate and return vb (value of body)
;eval((ef ea)) = vb ;(the function call is = to vb)
;
;;variable substitution
;n[x->v]=n;if variable is n, return n
;x[x->v]=v;if variable is the one ur looking for, return the v
;y[x->v]=y;if u found variable but its not the ones ur looking for, return the the one u found
;lambda(x).e[x->v]= lambda(x).e; if u found the variable inside of a function declaration, return the declaration
;lambda(y).e[x->v]= lambda(y).e[x->v]; if variable is not the one ur looking for in the function declaration, then subsitute the value in the function body
;(e1 e2)[x->v] = (e1[x->v] e2[x->v]); if a function call, find and replace on the funtcion and argument

(define one (lambda (x) (lambda (y) x)))
one;returns the first function
(one 1);;runs the first functions and returns the second function
(define two (one 1))
(two 2);runs the second function which returns the value of the first function's argument
((one 7)2);same as above

