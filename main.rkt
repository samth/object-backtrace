#lang racket/base
(require ffi/unsafe/vm)
(provide object-backtrace object-referrer)

(define (object-referrer o)
  (call-with-counts
   (lambda ()
      (for*/list ([gen (in-list (vm-eval '(object-backreferences)))]
                  [b (in-list gen)]
                  #:when (eq? (car b) o)
                  #:when (cdr b))
        (cdr b)))))

(define (object-backtrace o)
  (call-with-counts
   (lambda ()
     (define h (make-hasheq))
     (hash-set! h o null)
     (for* ([gen (in-list (vm-eval '(object-backreferences)))]
            [b (in-list gen)]
            #:when (hash-ref h (car b) #f))
       (hash-set! h (cdr b) null)
       (hash-update! h (car b) (lambda (v) (cons (cdr b) v))))
     h)))


(define (call-with-counts f)
  (dynamic-wind (lambda ()
                  (vm-eval '(enable-object-counts #t))
                  (vm-eval '(enable-object-backreferences #t))
                  (collect-garbage))
                f
                (lambda ()
                  (vm-eval '(enable-object-counts #f))
                  (vm-eval '(enable-object-backreferences #f)))))

                  
