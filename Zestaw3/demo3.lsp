(defun init ()
	(SETQ TREE '( 
	(D (VALUE . /) (LEFT . D1) (RIGHT . D2) (UP)) ;; może nie być (UP)jesli jest puste 
	(D1 (VALUE . +) (UP . D)(LEFT . D11) (RIGHT . D12)) 
	(D11 (VALUE . 2) (UP . D1)(LEFT) (RIGHT)) ;; może nie być podlist (LEFT)(RIGHT)) jesli sa puste 
	(D12 (VALUE . -) (UP . D1)(LEFT . D121) (RIGHT . D122)) (D121 (VALUE . 3) (UP . D12)) 
	(D122 (VALUE . a) (UP . D12)) (D2 (VALUE . *) (UP . D)(LEFT . D21) (RIGHT . D22)) 
	(D21 (VALUE . a) (UP . D2)) (D22 (VALUE . -) (UP . D2)(LEFT . D221) (RIGHT . D222)) 
	(D221 (VALUE . 4) (UP . D22)) (D222 (VALUE . b) (UP . D22)) 
	))
	(to-symbols tree)
)


(defun exa (L)
			(format t "~C~C" #\return #\linefeed)
			(format t "~C~C" #\return #\linefeed)
			(print L)
			(print (eval L))
) 

(defun demo  (&OPTIONAL (NR -1)) (
	cond 
		((= NR 1) 
			(init)
			(exa '(parent 'd1))
			(exa '(PUTPROP 'd1 'up 'd1))
			(exa '(parent 'd1))
			(print "inicjalizacja wykorzystuje funkcje TO-SYMBOLS")
			(print "nie mam innego pomyslu na jej demo")
			T
		)
		((= NR 2) 
			(init)
			(exa '(route 'd 'd11))
			(exa '(route 'd 'd22))
			(exa '(route 'd11 'd22))
			T
		)
		((= NR 3)  
			(init)
			(exa '(putprop 'd 'value '*))
			(exa '(putprop 'd1 'value 3))
			(exa '(putprop 'd2 'value 2))
			(exa '(COUNT-TREE 'd))
			T
		)
		((= NR 4) 
			(init)
			(exa '(to-assoc 'd))
			T	
		)

		(T 
			(format t "~C~C~C~Ctry (demo N) where N=1,2,3,4~C~C" #\return #\linefeed #\return #\linefeed #\return #\linefeed)
		)
))

(demo 1)
(demo 2)
(demo 3)
(demo 4)
(demo)

