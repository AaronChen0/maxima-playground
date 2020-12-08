(defvar bino-sum-arr)

(defun split-zeta-1 (i j s)
  (let (bb tt)
    (if (= (- j i) 1)
        (setq bb (expt i s)
              tt (if (oddp i) 1 -1))
        (let ((m (ash (+ i j) -1)))
          (multiple-value-bind (tl bl) (split-zeta-1 i m s)
            (multiple-value-bind (tr br) (split-zeta-1 m j s)
              (setq bb (* bl br)
                    tt (+ (* br tl) (* bl tr)))))))
    (values tt bb)))

(defun zeta-init (n)
  (setf bino-sum-arr (make-array (1+ n) :initial-element 1))
  (loop with sum = 1
        for i from 1 to (ash n -1)
        for j from n downto 1
        do (setf sum (floor (* sum j) i) (aref bino-sum-arr i) sum))
  (loop for i from (1+ (ash n -1)) to n
        do (setf (aref bino-sum-arr i) (aref bino-sum-arr (- n i))))
  (loop for i from (1- n) downto 1
        do (incf (aref bino-sum-arr i) (aref bino-sum-arr (1+ i)))))

(defun split-zeta-2 (i j s n)
  (let (bb tt)
    (if (= (- j i) 1)
        (setq bb (expt i s)
              tt (aref bino-sum-arr (- i n))
              tt (if (oddp i) tt (- tt)))
        (let ((m (ash (+ i j) -1)))
          (multiple-value-bind (tl bl) (split-zeta-2 i m s n)
            (multiple-value-bind (tr br) (split-zeta-2 m j s n)
              (setq bb (* bl br)
                    tt (+ (* br tl) (* bl tr)))))))
    (values tt bb)))

(defun comp-zeta (s prec)
  (let ((fpprec prec)
        nr tt1 bb1 tt2 bb2)
    (setq nr (+ 3 (ceiling fpprec 3))) ;; nr of summands
    (zeta-init nr)
    (multiple-value-setq (tt1 bb1) (split-zeta-1 1 (1+ nr) s))
    (multiple-value-setq (tt2 bb2) (split-zeta-2 (1+ nr) (+ 1 nr nr) s nr))
    (setf bb2 (ash bb2 nr)
          tt1 (+ (* tt1 bb2) (* tt2 bb1))
          bb1 (* bb1 bb2)
          tt1 (ash tt1 (- s 1))
          bb1 (- (ash bb1 (- s 1)) bb1))
    (fpquotient (intofp tt1)
                (intofp bb1))))

(defun zeta11 (s)
  (let* ((n (+ 3 (ceiling fpprec 2.5431)))
         (z 0) (c (ash 1 (1- (* 2 n)))) (d c))
    (loop for k downfrom n to 1
          for tt = (truncate d (expt k s))
          do (setf z (if (oddp k) (+ z tt) (- z tt))
                   c (* c (* k (1- (* 2 k))))
                   c (truncate c (* 2 (- n k -1) (+ n k -1)))
                   d (+ d c)))
    (fpquotient (intofp (ash z (- s 1)))
                (intofp (- (ash d (- s 1)) d)))))

(defun fpzeta (n)
  (let ((zeta (zeta11 n)))
    (bcons (list (fpround (car zeta)) (cadr zeta)))))
