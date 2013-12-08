
(defun exa (L)
			(format t "~C~C" #\return #\linefeed)
			(format t "~C~C" #\return #\linefeed)
			(print L)
			(print (eval L))
) 

(defun demo  (&OPTIONAL (NR -1)) (
	cond 
		((= NR 1) 
			(exa '(NAME 'KOS))
			(exa '(NAME '4))
			(exa '(NBRSP 'kos 'kruk))
			(exa '(NBRSP '4 'borek))
			(exa '(NBRSP '404 'borek))
			(exa '(NBRS 'KOWAL))
			(exa '(NBRS '13))
			(exa '(EMPTY))
			T
		)
		((= NR 2) 
			(exa '(BLOK))
			(exa '(BLOK :os 'NOWAK))
			(exa '(BLOK :floor 3))			
			T
		)
		((= NR 3) 
			(exa '(B-LIST))	
			(exa '(B-LIST :name 'name-t))	
			(exa '(B-PRINT))	
			T
		)
		((= NR 4) 
			(exa '(IN '(zbigniew czarny) :nr 11))
			(exa '(IN '(julian krol)))
			T	
		)
		((= NR 5) 
			(exa '(OUT 'krol))
			(exa '(OUT 'nikt404))
			(exa '(OUT 'gaj))
			T
		)
		(T 
			(format t "~C~C~C~Ctry (demo N) where N=1,2,...,5~C~C" #\return #\linefeed #\return #\linefeed #\return #\linefeed)
		)
))

;(demo 1)
;(demo 2)
;(demo 3)
;(demo 4)
;(demo 5)
;(demo)

