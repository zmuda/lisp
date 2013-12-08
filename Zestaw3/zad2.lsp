(defun SPLIT (STRING  &optional (SEP " "))
	(let ((start 0)(res (list))) 
		(loop while (search SEP (subseq STRING start)) do 
			(push (subseq STRING start (+ start (search SEP (subseq STRING start)))) res)
			(setf start (+ 1 (+ start (search SEP (subseq STRING start)))))
		)
		(push (subseq STRING start ) res)
		res
	)
)
(defun SCAL (LICZBA) 
	(cond ((position '\. LICZBA)
		(+(apply '+ (subseq liczba 0 (position '\. LICZBA))) 
		(/ (apply '+  (subseq liczba (+ 1(position '\. LICZBA)))) 100))
		)
		(T (apply '+ LICZBA))
	)
)

(defun mremove-if (test sequence &KEY (recursive nil))
(cond
	((listp sequence)
		(mapcan #'(lambda (x) (cond 
			((and recursive (not(atom x))) (list (mremove-if test x :recursive T)))
			((not(funcall test x)) (list x))
		)) sequence)
	)
	((stringp sequence)
		(coerce (mapcan #'(lambda (x) (cond 
			((and recursive (not(atom x))) (list (mremove-if test x :recursive T)))
			((not(funcall test x)) (list x))
		)) (coerce sequence 'list)) 'string)
	)
	((arrayp sequence)
		(coerce (mapcan #'(lambda (x) (cond 
			((and recursive (not(atom x))) (list (mremove-if test x :recursive T)))
			((not(funcall test x)) (list x))
		)) (coerce sequence 'list)) 'array)
	)
))

(defun SPLIT-TYPE (TYPE SOURCE)
(funcall type
	(sort 
		(apply #'nconc(map 'list #'(lambda (x) (cond ((numberp x) (list x)))) source)) 
	#'<)
	(sort 
		(apply #'nconc(map 'list #'(lambda (x) (cond ((listp x) (list x)))) source)) 
	#'< :key #'CAR)
	(sort 
		(apply #'nconc (map 'list #'(lambda (x) (cond ((not(or(numberp x)(listp x))) (list x)))) source)) 
	#'string<) 
))

(defun  RSORT (DATA FUN) 
	(let ((core (list))(rest (list))) 
		(mapcar #'(lambda (x) (cond 
				((not(atom x)) (setq rest (cons (rsort x fun) rest)))
				(T (setq core (cons x core)))
		)) data)
		(append core rest)
	)
	
)

(defun MSORT (DATA PREDICATE &key recursive key) 
	(cond ((and recursive key)	
			(append 
				(sort (car(SPLIT-TYPE 'list DATA)) predicate) 
				(sort 
					(mapcar #'(lambda (x) 
						(MSORT x predicate :recursive T :key key)
					)(second (SPLIT-TYPE 'list DATA)))
				predicate :key key) 
			)
		)
		(recursive nil)
		(T (append
			(sort (car(SPLIT-TYPE 'list DATA)) predicate) 
			(sort (second (SPLIT-TYPE 'list DATA)) predicate :key key) 
		))
	)
)
