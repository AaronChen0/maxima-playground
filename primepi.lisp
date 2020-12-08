;; prime counting
(load "~/quicklisp/local-projects/primecount/primecount.lisp")

;; (defmfun $primepi (n)
;;   (cond ((and (integerp n) (>= n 0)) (primecount:prime-count n))
;;         (t `(($primepi) ,n))))

(ql:quickload "cl-primecount" :silent t)

(defmfun $primepi (n)
  (cond ((and (integerp n) (>= n 0)) (cl-pc:primepi-str (write-to-string n)))
        (t `(($primepi) ,n))))

(defmfun $prime (n)
  (cond ((and (integerp n) (>= n 0)) (cl-pc:nth-prime n))
        (t `(($prime) ,n))))

(defmfun $primesum (n)
  (cond ((and (integerp n) (>= n 0)) (primecount:prime-sum n))
        (t `(($primesum) ,n))))
