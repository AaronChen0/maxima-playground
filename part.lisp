(defun parin (str &key (radix 10))
  (labels ((pari (start end)
             (let* ((len (- end start)) (mid (floor (+ start end) 2)))
               (if (< len 19) (parse-integer str :start start :end end
                                                 :radix radix)
                   (+ (* (pari start mid)
                         (expt radix (- end mid)))
                      (pari mid end))))))
    (pari 0 (length str))))

(defmfun $numpart (n)
  (let* ((str (with-output-to-string (str)
               (sb-ext:run-program "/usr/bin/python"
                                   (list "-c" (concatenate 'string "from flint import *;showgood(lambda:arb.partitions_p(" (write-to-string n) "),dps=" (write-to-string (+ 3 (floor (* 1.11401 (sqrt n))))) ")"))
                                   :output str)))
         (pos (position #\. str)))
    (setf str (subseq str 0 pos))
    (parin str)))
