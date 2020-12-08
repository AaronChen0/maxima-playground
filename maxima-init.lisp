;; make bignum computation efficient
;#+sbcl (require :sb-gmp)

(loop for file in (list "chudnovsky.lisp" "exprat.lisp" "zeta3.lisp" "zeta.lisp" "catalan.lisp" "log2.lisp" "eval_string.lisp" "unicode-sniffer.lisp" "stringproc.lisp" "printf.lisp" "belln.lisp" "factorial.lisp" "getpi.lisp" "misc.lisp")
      do ($load file))

(defmfun $myprimep (n)
  (or (= n 2)
      (and (integerp n) (> n 1)
           (multiple-value-bind (q k) (miller-rabin-decomposition n)
             (miller-rabin-kernel n q k 2))
           (primep-lucas n))))
