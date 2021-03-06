;Project 1: Scheme & Natural Language Parsing
;Written by David Hausner
;10-4-15
;davidrhausner@gmail.com
(define (BOR x y)
	(cond 
		((eq? x #t) #t)
		((eq? y #t) #t)
	(else	#f))
)
(define (BAND x y)
	(if (eq? x #t)
		(if (eq? y #t)
			#t
			#f)
		#f)
)
(define (pos? x)
	(if (> x 0)
        	#t
		#f)
)
(define (in? i l)
	(if (memq i l)
		#t #f)
)
(define (reduce op l)
	(let loop ((res (car l)) (l (cdr l)))
		(if (null? l)
			res
				(loop (op res (car l)) (cdr l))))
)
(define filter
	(lambda (p l)
		(cond	((null? l) '())
			((p (car l)) (cons (car l) (filter p (cdr l))))
			(else (filter p (cdr l)))))
)
(define (det? i)
	(if (in? i '(a an the))
		#t
		#f)
)
(define (noun? i)
	(if (in? i '(apple bicycle car cow dog fox motorcycle path pie road truck))
		#t
		#f)
)
(define (verb? i)
	(if (in? i '(commutes destroys drives eats jumps makes occupies rides stops travels walks))
		#t
		#f)
)
(define (adj? i)
	(if (in? i '(black brown fast hairy hot quick red slow))
		#t
		#f)
)
(define (prep? i)
	(if (in? i '(around at of on over to under))
		#t
		#f)
)
(define (det l)
	(if (det? (car l))
		(cdr l)
		'()
	)
)
(define (noun l)
	(if (noun? (car l))
		(cdr l)
		'()
	)
)
(define (verb l)
	(if (verb? (car l))
		(cdr l)
		'()
	)
)
(define (adj l)
	(if (adj? (car l))
		(cdr l)
		'()
	)
)
(define (prep l)
	(if (prep? (car l))
		(cdr l)
		'()
	)
)
(define (nounphrase2 l)
    (cond ((null? l) #f)
        ((noun? (car l)) (cdr l))
        ((adj? (car l)) (nounphrase2 (adj l)))
        (else (values (#f (cdr l))))
    )
)
(define (nounphrase1 l)
    (cond ((null? l) #f)
        ((det? (car l)) (nounphrase2 (cdr l)))
        (else (nounphrase2 l))
    )
)
(define (verbphrase l)
    (cond ((null? l) #f)
        ((verb? (car l))
            (if (prep? (car (verb l)))
                (nounphrase1 (prep (verb l)))
                (nounphrase1 (verb l))
            )
        )
        (else (values (#f l)))
    )
)
(define (sentence l)
    (verbphrase (nounphrase1 l))
)
(define (OK l)
    (cond ((> (/ (length (filter adj? l)) (length l)) 0.25) #f)
    (else #t)
    )
)
