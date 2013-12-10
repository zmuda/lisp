
(defun exa (L)
			(format t "~C~C" #\return #\linefeed)
			(format t "~C~C" #\return #\linefeed)
			(print L)
			(print (eval L))
) 

(defun demo  (&OPTIONAL (NR -1)) (
	cond 
		((= NR 1) 
			(exa '(NAND T T))
			(exa '(NAND T nil))
			(exa '(NAND nil nil))
			T
		)
		((= NR 2) 
			(exa '(SETQ A 'A B 'B) )
			(exa ' (IF-NOT (EQ A B) (PRINT A) (PRINT B) (CONS A B)))		
			(exa '(SETQ A 'A B 'A) )
			(exa ' (IF-NOT (EQ A B) (PRINT A) (PRINT B) (CONS A B)))		
			T
		)
		((= NR 3) 
			(exa '(DO-EVEN (P 0 7)  (print (* p p))))	
			(exa '(DO-IF (P 0 7 T #'oddp) (print p)))		
			T
		)
		((= NR 4) 
			(exa '(setq a (make-array '(4 3) :initial-element 0)))
			(exa '(print2d a))
			(exa '(print2d (fill2d a 'a #'oddp)))
			(exa '(print2d (fill2d a 'B #'evenp)))
			T	
		)

		(T 
			(format t "~C~C~C~Ctry (demo N) where N=1,2,3,4~C~C" #\return #\linefeed #\return #\linefeed #\return #\linefeed)
		)
))

;(demo 1)
;(demo 2)
;(demo 3)
;(demo 4)
;(demo)

