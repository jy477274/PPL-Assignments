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
    ;(define startstate (state-from-string-rep puzzle))
    (let* ([startstate (state-from-string-rep puzzle)]
           [current (list (list '() startstate))]
           [next (list '())]
           [seen (make-eqv-hashtable)])

          ;Reformatted into begin block
          (begin
            (hashtable-set! seen startstate #t)
            (run seen current next))))
          ;(hashtable-set! seen startstate #t)

          ;Maybe can do a if run #f then print no solution
          ;(begin (run seen current next))))

  ;Calls run recursively until solution is found or next is empty
  (define (run seen current next)
    (print "In run \n")
    (if (null? (sol-search seen current next))
        #f ;No solution
        (run seen current next))) ;may need a begin here but not sure

  ;The meat that uses moves to generate neighbours to each state in current.
  ;If they haven't been seen add to seen and next lists.
  ;Check if solution and just print and exit.
  (define (sol-search seen current next)
    (print "In sol-state \n")
    (for state in current
         (let* ([neighbours (moves (cadr state))])
           (for neighbour in neighbours
                (cond [(state-is-solved? (car neighbour)) ;may need to change car depending on moves
                       (begin
                         (for-each println (reverse (cdr neighbour))) ;may need to change cdr
                         (exit))]

                      [(not(hashtable-contains? seen (car neighbour))) ;may need to change car
                       (begin
                         ;cons state's moves onto neighbour before adding to next
                         (cons (car state) (cdr neighbour))
                         (hashtable-set! seen (car neighbour));may need to change car
                         (cons neighbour next))])))))


  (define (moves state)
    (print "In moves \n")
    (print state)
    (let*([position (make-list 0 64)] ;need make-list func
          [disp '(-4 -3 -2 -1 1 2 3 4)])
      (begin
        (filter (lambda (value) value)
                (apply append
                       (map (lambda (pos)
                              (if (state-is-horizontal? state pos)
                                  (begin
                                    (map (lambda (disp)
                                         (begin
                                           (if (state-horizontal-move state pos disp)
                                               (begin
                                                 (cons state
                                                       (cons (state-horizontal-move state pos disp)
                                                             (state-make-move pos disp)))) #f))) disp))
                                    (begin
                                      (map (lambda (disp)
                                             (begin
                                               (if (state-vertical-move state pos disp)
                                                   (begin
                                                     (cons state
                                                           (cons (state-vertical-move state pos disp)
                                                                 (state-make-move pos disp))))#f)))disp))))

                            (filter (lambda (pos) (state-is-end? state pos)) position)))))))


  (define (make-list start end)
    (if (<= start end)
        (cons start (make-list (+ start 1) end))
        '()))
);close library


