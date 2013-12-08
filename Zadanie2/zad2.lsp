
(defun ROOT (&OPTIONAL (TREE TREE))
	(find-if #'(lambda (x) (not(cdr(assoc 'up (eval x))))) TREE)
)
(defun DOWN (id &OPTIONAL (TREE TREE)) 
	(mapcan #'(lambda (x)
	(cond 
		((equal id (cdr(assoc 'up (eval x)))) (list x))
		(T nil)
	)
	) TREE)
	
	(let (
		(branch (cdr (assoc 'down (eval id))))
	)	
		(cond 
			((null branch) nil)
			((atom branch) (list branch))
			(T branch)
		)
	)
)
(defun UP (id &OPTIONAL (TREE TREE)) 
	(cdr (assoc 'up (eval id)))
)

(defun BRANCHLIST (id &OPTIONAL (TREE TREE))
	(append (list id) (delete nil (list (mapcan #'(lambda (x) 
		(BRANCHLIST x tree)
	) (down id)))))
)
(defun DLIST (&OPTIONAL (TREE TREE))
	(branchlist (root tree))
)
(defun ADD (New Parent Name P &OPTIONAL (TREE TREE))
	(set new (pairlis '(up name p down) (list Parent Name P nil)))
	(mapcar #'(lambda (sibling) 
		(setf (cdr(assoc 'P (eval sibling))) (* (- 1 P) (cdr(assoc 'P (eval sibling)))))	
	)(down parent))
	(push new tree)
)
(defun UNINTERN-BRANCH (Dn &OPTIONAL (TREE TREE))
	(mapcan #'(lambda (x) 
		(UNINTERN-BRANCH x tree)
	) (down Dn))
	(UNINTERN Dn)
	(delete dn tree)
)
(defun DEL(Dn &OPTIONAL (TREE TREE))
	(cond 
		((not(boundp dn)) nil)
		((not(cdr(assoc 'up (eval dn))))
			(UNINTERN-BRANCH Dn)(unintern 'tree)
		)
		(T 
			(delete dn (assoc 'down (eval (up dn))))
			(mapcar #'(lambda (sibling) 
				(setf (cdr(assoc 'P (eval sibling))) (/ (cdr(assoc 'P (eval sibling))) (- 1 (cdr(assoc 'P (eval Dn)))) ) )	
			)(down (up Dn)))
			(delete dn (down (up dn)))
			(UNINTERN-BRANCH Dn)(delete Dn tree)
		)
	)
)
(defun CHECKP-BRANCH (D TREE)
	(cond 
		((null (down d)) 1.0)
		(T (apply '+ (mapcar #'(lambda (x) (* (cdr(assoc 'p (eval x))) (CHECKP-BRANCH x tree)))(down d))))
	)
)
(defun CHECKP (&OPTIONAL (TREE TREE))
	(> 	(CHECKP-BRANCH (root tree) tree)	0.9999999)
)