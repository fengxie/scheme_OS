(define (iter lst)
  (display (car lst))
  (if (null? lst)
      #t
      (iter (cdr lst))))
(iter '(a b))
(display)
