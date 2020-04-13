#lang racket/base
(require ffi/unsafe/vm)
(provide object-backtrace)

(define (object-backtrace o)
  (vm-eval '(enable-object-counts #t))
  (vm-eval '(enable-object-backreferences #t))
  (collect-garbage)
  (begin0
      (for/list ([b (in-list (vm-eval '(object-backreferences)))]
                 #:when (eq? (car b) o))
        (cdr b))
    (vm-eval '(enable-object-counts #f))
    (vm-eval '(enable-object-backreferences #f))))
