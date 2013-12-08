
(defun exa (L)
			(format t "~C~C" #\return #\linefeed)
			(format t "~C~C" #\return #\linefeed)
			(print L)
			(print (eval L))
) 

(defun demo  (&OPTIONAL (NR -1)) (
	cond 
		((= NR 1) 
			(exa '(SPLIT "Ala Ma Kota"))
			(exa '(SPLIT "Ala Ma Kota" "o"))
			T
		)
		((= NR 2) 
			(exa '(scal  '(100 20 3 \. 30 4)) )
			(exa '(scal  '(\. 30 4)) )
			(exa '(scal  '(100 20 3 )) )
			T
		)
		((= NR 3) 
			(exa '(MREMOVE-IF #'upper-case-p "Ala Ma Kota"))	
			(exa '(MREMOVE-IF #'evenp #(1 2 3 4 5)))		
			(exa '(MREMOVE-IF #'evenp '(1 2 3 4 5)))
			(exa '(MREMOVE-IF #'evenp '(1 2 3 4 (5 6 7 8) 9 (10 11)) :recursive T))
			T
		)
		((= NR 4) 
			(exa '(split-type 'vector '(10 z a (5 6) #\q (1 a w e) (2 b) u #\d 3 6 "bee" "wolo")))
			(exa '(split-type 'list '(10 z a (5 6) #\q (1 a w e) (2 b) u #\d 3 6 "bee" "wolo")))		
			(exa '(rsort '(1 2 3 4 ) #'>))		
			(exa '(rsort '(1 2 3 4 (10 11) (5 6 (7) (8)) (12 13) 9 ) #'>))
			(exa '(msort '(1 2 3 4 (10 11) (5 6 (7) (8)) (12 13) 9 ) #'> :key #'car))		
			(exa '(msort '(1 2 3 4 (10 11) (5 6 (7) (8)) (12 13) 9 ) #'> :recursive T :key #'car))		
			T	
		)

		(T 
			(format t "~C~C~C~Ctry (demo N) where N=1,2,3,4~C~C" #\return #\linefeed #\return #\linefeed #\return #\linefeed)
		)
))

;(demo 1)
;(demo 2)
;(demo 3)
(demo 4)
;(demo)

