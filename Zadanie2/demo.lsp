
(defun exa (L)
			(format t "~C~C" #\return #\linefeed)
			(format t "~C~C" #\return #\linefeed)
			(print L)
			(print (eval L))
) 

(defun demo  (&OPTIONAL (NR -1)) (
	cond 
		((= NR 1) 
			(exa '(ROOT))
			(exa '(down 'd))
			(exa '(down 'd1))
			(exa '(up 'd))
			(exa '(up 'd1))
			T
		)
		((= NR 2) 
			(exa '(dlist))			
			T
		)
		((= NR 3) 
			(exa '(mapcar #'(lambda (x) (assoc 'p (eval x))) (down 'd)))
			(exa '(add 'd99 'd "magic" 0.5))
			(exa '(mapcar #'(lambda (x) (assoc 'p (eval x))) (down 'd)))
			
			T
		)
		((= NR 4) 
			(exa '(mapcar #'(lambda (x) (assoc 'p (eval x))) (down 'd)))
			(exa '(del 'd2 ))
			(exa '(mapcar #'(lambda (x) (assoc 'p (eval x))) (down 'd)))
			(exa '(del 'd1 ))
			(exa '(mapcar #'(lambda (x) (assoc 'p (eval x))) (down 'd)))
			
		)
		((= NR 5) 
			(exa '(checkp ))
			(exa '(setf (cdr(assoc 'p d1)) 0.0))
			(exa '(checkp ))
			T
		)
		(T 
			(format t "~C~C~C~Ctry (demo N) where N=1,2,...,5~C~C" #\return #\linefeed #\return #\linefeed #\return #\linefeed)
		)
))

