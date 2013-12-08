(defmacro NAND (ARG1 ARG2) `(NOT (AND ,ARG1 ,ARG2)))

(defmacro IF-NOT (TEST &BODY BODY) 
	`(COND 
        ((NOT ,TEST) ,@BODY)
	)		
)

(defmacro DO-EVEN ((index start end &optional (result nil) (rule '(lambda (x) (+ x 2)))) &BODY BODY)
   `(DO (
			(,index (cond ((= 1 (mod ,start 2)) (+ ,start 1)) (T ,start)) (,rule ,index))
		) 
	   ((> ,index ,end ) ,result)
	   ,@BODY
	)
) 
;; takie samo - nie zwrocilem uwagi na zmiane nazwy 
(defmacro DO-IF ((index start end &optional (result nil) (rule '(lambda (x) (+ x 2)))) &BODY BODY)
   `(DO (
			(,index (cond ((= 1 (mod ,start 2)) (+ ,start 1)) (T ,start)) (,rule ,index))
		) 
	   ((> ,index ,end ) ,result)
	   ,@BODY
	)
)

(defun FILL2D (TAB2D VALUE &optional RULE) 
	
	(let ((x 0)(tail tab2d)(offset 0))
		(cond (RULE 
				(DO-IF (i 0 999999 T (lambda (x) (funcall rule x))) 
					;indeks w wierszu	
					(setf x (- i offset))
					(loop while (and tail (>= x (length(car tail)))) do 
						(setf offset (+ offset (length(car tail))))
						(setf tail (cdr tail))
						(setf x (- i offset))
					)
					(cond ((null tail) (return tab2d)))
					(setf (subseq (car tail) x (+ 1 x)) (list VALUE))
				)
			)
			(T 		
				(DO-IF (i 0 999999 T) 
					;indeks w wierszu	
					(setf x (- i offset))
					(loop while (and tail (>= x (length(car tail)))) do 
						(setf offset (+ offset (length(car tail))))
						(setf tail (cdr tail))
						(setf x (- i offset))
					)
					(cond ((null tail) (return tab2d)))
					(setf (subseq (car tail) x (+ 1 x)) (list VALUE))
				)
			)
		)
	)
	tab2d
)
(defun print2d (tab2d)
	(mapcar #'(lambda (row) (print row)) tab2d)
	T
)



