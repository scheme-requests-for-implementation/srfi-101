#!r6rs

;;;; SPDX-FileCopyrightText: 2009 David Van Horn
;;;;
;;;; SPDX-License-Identifier: MIT

(library (srfi :101 random-access-lists syntax ra-datum)
  (export datum->ra-datum)
  (import (rnrs base)
          (rnrs bytevectors)
          (prefix (srfi :101 random-access-lists procedures) ra:))

  (define (datum->ra-datum d)
    (cond ((boolean? d) d)
          ((number? d) d)
          ((char? d) d)
          ((string? d) d)
          ((symbol? d) d)          
          ((bytevector? d) d)
          ((null? d) d)
          ((vector? d) 
           (vector-map datum->ra-datum d))
          ((pair? d)
           (ra:cons (datum->ra-datum (car d))
                    (datum->ra-datum (cdr d))))
          (else
           (error "Unkown datum" d)))))
