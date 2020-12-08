(defun split-chudnovsky (i j)
  (let (aa pp qq tt gg (num 10939058860032000))
    (if (= (- j i) 1)
        (if (= i 0)
            (setq aa 13591409 pp 1 qq 1 tt aa)
            (setq aa (+ (* i 545140134) 13591409)
                  pp (* (- (* 6 i) 5) (- (* 2 i) 1) (- (* 6 i) 1)) 
                  gg (gcd pp num)  ; C^3/24
                  pp (floor pp gg)
                  qq (* (floor num gg) (expt i 3))
                  tt (if (evenp i) (* aa pp) (- (* aa pp)))))
        (let ((m (ash (+ i j) -1)))
          (multiple-value-bind (tl ql pl) (split-chudnovsky i m)
            (multiple-value-bind (tr qr pr) (split-chudnovsky m j)
              (setq pp (* pl pr)
                    qq (* ql qr)
                    tt (+ (* qr tl) (* pl tr)))))))
    (values tt qq pp)))

(defun get-pi (prec)
  (let ((terms (ceiling prec (log (/ (expt 640320 3) 24 72) 10d0)))
        (sqrtc (isqrt (* 10005 (expt 10 (* 2 prec))))))
    (multiple-value-bind (tt qq) (split-chudnovsky 0 (1+ terms))
      (values (truncate (* qq 426880 sqrtc) tt)))))
