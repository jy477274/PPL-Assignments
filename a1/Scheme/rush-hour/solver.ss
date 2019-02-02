;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; rush-hour/solver.ss
;;;
;;; Rush Hour puzzle solver
;;; (C) 2019 Norbert Zeh (nzeh@cs.dal.ca)
;;;
;;; Implementation of the search for a shortest move sequence that solves a
;;; given Rush Hour puzzle.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(library (rush-hour solver)
  (export solve-puzzle)
  (import (rnrs (6))
          (rnrs hashtables (6))
          (rush-hour state)
          (rush-hour utils))

(define-syntax for
  (syntax-rules (in as)
    [(for elem in lst body ...)
     (for-each (lambda (elem)
                 body ...)
                 lst)]
    [(for lst as elem body ...)
     (for elem in lst body ...)]))

(define-syntax while
  (syntax-rules ()
    [(while condition body ...)
     (let loop ()
       (if condition
           (begin body ... (loop))
           (void)))]))

  ;; Solve a Rush Hour puzzle represented as a 36-character string listing the
  ;; 6x6 cells of the board in row-major order.  Empty cells are marked with
  ;; "o".  Occupied cells are marked  with letters representing pieces.  Cells
  ;; occupied by the same piece carry the same letter.
  (define (solve-puzzle puzzle)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;
    ;; IMPLEMENT THIS FUNCTION
    ;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;Create start state from string representation
    (let* ([startstate (state-from-string-rep puzzle)])
          ([current (make-eqv-hashtable)])
          ([next (make-eqv-hashtable)])
          ([seen (make-eqv-hashtable)])

          (hashtable-set! current startstate '())
          ;call run here
      )
    ))

   (define (run current next)
     (while #t
            (for seq in current
                 (let* ([sol (search(seq))])
        ;not sure about if sol return sol and if self.next

   )

   (define (search path)
     (let* ([currstate (cadr path)])
           ([movelist (moves currstate)])
       (for nextstateinfo in movelist
            (cond [(state-is-solved? (car nextstateinfo))
                   (cons (car path) (cdr nextstateinfo))
                   path]
            ;CAN PROBABLY DO (hashtable-contains? seen (car nextstateinfo)) instead of this deal
                   [((eq? (car nextstateinfo) (filter
                                              (lambda (x)
                                                (eq? (car nextstateinfo))))))
                   (hashtable-set! next (car nextstateinfo) (cons (car path) (cdr nextstateinfo)))
                   (hashtable-set! seen (car nextstateinfo) (cdr nextstateinfo)]))
                   ;append path+move, next_state to next list DONE ABOVE

                   ;add next_state to the seen list DONE ABOVE
         ;return none? is this needed? #f is returned I believe

       ))

   (define (moves state)
     (let outerloop ([pos 0])
       (if (< pos 64)
           (if (state-is-end? state pos)
              (call/cc (lambda (cont);may need to shift this to before the loop
                (define helper
                 (cond [(state-is-horizontal? state pos)
                        (let innerhoriz1 ([k 1])
                          (if (< k 5)
                              (let ([new_state (state-horizontal-move state pos k)])  )
                              ;if not new_state, break, yield
                              (if(!new_state);may need to reverse this logic
                                (cont ());return null(?)
                                (new_state (state-horizontal-move state pos k)))

                              (innerhoriz1 (+ k 1))))
                        (let innerhoriz2 ([k 1])
                          (if (< k 5)
                              (let ([new_state (state-horizontal-move state pos (- k))])  )
                              ;if not new_state, break, yield
                              (if(!new_state);may need to reverse this logic
                                (cont ());return null?
                                (new_state (state-horizontal-move state pos (- k))))
                              (innerhoriz2 (+ k 1))))]
                       [(state-is-vertical? state pos)
                        (let innervert1 ([k 1])
                          (if (< k 5)
                              (let ([new_state (state-vertical-move state pos k)])  )
                              ;if not new_state, break, yield
                              (if(!new_state);may need to reverse this logic
                                (cont ());return null?
                                (new_state (new_state (state-vertical-move state pos k))))
                              (innervert1 (+ k 1))))
                        (let innervert2 ([k 1])
                          (if (< k 5)
                              (let ([new_state (state-vertical-move state pos (- k))])  )
                              ;if not new_state, break, yield
                              (if(!new_state);may need to reverse this logic
                                (cont ());return null?
                                (new_state (state-vertical-move state pos (- k))))
                              (innervert2 (+ k 1))))]
                      )
           (outerloop (+ pos 1)))))))))

