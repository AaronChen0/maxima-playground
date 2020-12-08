(defun comp-log2 ()
  (let ((res
          (let ((fpprec (+ fpprec 12)))
            (fpplus 
             (fpdifference (n*atanh-1/k 18 26) (n*atanh-1/k 2 4801))
             (n*atanh-1/k 8 8749) ))))
    (list (fpround (car res)) (cadr res)) ))

;; log(2)=72*arccot(99)-18*arccot(449)+34*arccot(4801)-10*arccot(8749)
(defun comp-log2-2 ()
  (let ((res
          (let ((fpprec (+ fpprec 12)))
            (fpdifference
             (fpplus (n*atanh-1/k 72 99) (n*atanh-1/k 34 4801))
             (fpplus (n*atanh-1/k 18 449) (n*atanh-1/k 10 8749))))))
    (list (fpround (car res)) (cadr res))))

;; log(2)=144*arccot(251)+54*arccot(449)-38*arccot(4801)+62*arccot(8749)
(defun comp-log2-3 ()
  (let ((res
          (let ((fpprec (+ fpprec 12)))
            (fpdifference
             (fpplus (fpplus (n*atanh-1/k 144 251) (n*atanh-1/k 54 449))
                     (n*atanh-1/k 62 8749))
             (n*atanh-1/k 38 4801) ))))
    (list (fpround (car res)) (cadr res)) ))

(defun $log2 () (bcons (comp-log2)))
