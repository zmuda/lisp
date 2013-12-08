
(defun B-ASSOC ( PROP IDENT &OPTIONAL (BLOCK BLOK)) 
	(assoc prop (cdr (assoc ident block)))
)
(defun NAME (IDENT &OPTIONAL (BLOCK BLOK)) 
	(cdr (b-assoc 'name ident block))
)
(defun  NBRSP (IDENT1 IDENT2 &OPTIONAL (BLOCK BLOK))
	(cond ((intersection (list ident1) (cdr(b-assoc 'nbrs ident2 block))) T))
)

(defun  NBRS (OS &OPTIONAL (BLOCK BLOK))
	(let((floor (b-assoc 'pietro os block)))
	(mapcan #'(lambda (nbr) (
		cond ((equal floor (b-assoc 'pietro nbr block)) (list nbr))
	))(cdr(b-assoc 'nbrs os block)))
))

(defun EMPTY(&OPTIONAL (BLOCK BLOK)) 
	(mapcan #'(lambda (id) (
		cond ((numberp (car id)) (list (car id)))
	)) BLOCK)
)
(defun BLOK (&KEY (BLOCK BLOK) OS FLOOR) 
	(mapcan #'(lambda (x) 
	(cond 
		((and os (= (cdr (B-ASSOC 'pietro os block)) (cdr (assoc 'pietro (cdr x))))) (list(car x)))
		((and floor (= FLOOR (cdr (assoc 'pietro (cdr x))))) (list(car x)))
		((and (not os) (not floor)) (list(car x)))
		(T nil)
	)
	) blok)
)

(defun B-LIST (&KEY (BLOCK BLOK) (NAME NIL))
	(mapcar
		#'(lambda (flr) 
		(mapcar
			#'(lambda (ident) (cond
				((equal name 'name-t) ident)
				((and (null name) (numberp ident)) ident)
				(T (cdr (b-assoc 'name ident block)))
			))
		(BLOK :floor flr)
		)
		)
	(sort (remove-duplicates (mapcar #'(lambda (x) (cdr(assoc 'pietro (cdr x)))) BLOCK)) #'>)
	)
)
(defun B-PRINT (&KEY (BLOCK BLOK)  (NAME NIL))
	(mapcar #'(lambda (ids) (print ids)) (B-LIST))
	T
)
(defun FIND-FLAT (&KEY (BLOCK BLOK) OS NR) 
	(assoc (cond 
		((not(null nr))
		(car (mapcan #'(lambda (x) 
		(cond 
			((equal nr (cdr (b-assoc 'nr x block))) (list x))
		)
		) (blok :block blok))))
		((not(null os)) os)
		(T (find-if 'numberp (blok :block blok)) )
	) block)
)


(defun IN (LISTA_IMIE_NAZWISKO &KEY (BLOCK BLOK) (NR NIL)) 
	(let ((record (find-flat :block block :nr nr)))
	(mapcar #'(lambda (nbr) 
		(delete nr (push (cadr LISTA_IMIE_NAZWISKO)(cdr (b-assoc 'nbrs nbr block))))
	) (cdr (b-assoc 'nbrs (car record) block)))
	(setf (car record) (cadr LISTA_IMIE_NAZWISKO))
	(push (cons 'name LISTA_IMIE_NAZWISKO) (cdr record))
	block
	)
)
(defun OUT (IDENT &KEY (BLOCK BLOK))
	(cond 
	((not(find ident (blok :block block))) nil)
	(T
	(let ((record (find-flat :block block :os ident))
		(flatnr (cdr (assoc 'nr (cdr (find-flat :block block :os ident))))))
	(mapcar #'(lambda (nbr) 
		(delete ident (push flatnr (cdr (b-assoc 'nbrs nbr block))))
	) (cdr (b-assoc 'nbrs (car record) block)))
	(setf (car record) flatnr)
	(delete-if #'(lambda (x) (and (listp x)(equal (car x) 'name))) record)
	block
	)))
)
