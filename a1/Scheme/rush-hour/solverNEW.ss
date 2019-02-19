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
    (let ([seen (make-eqv-hashtable)])
      (hashtable-set! seen (state-from-string-rep puzzle) #t)
      (let search ([current (list (cons (state-from-string-rep puzzle) '() ))])
        (let* ([next (apply append (for state in current
                                        (moves state seen)))])
          (for-each println next)
          (if (null? next)
              #f
              (for neighbour in next
                   (if (state-is-solved? (car neighbour))
                       (reverse (cdr neighbour))
                       (search next))))))))



  (define (moves state seen)
    ;(print "In moves \n")
    (let loop ([neighbours '()]
               [candidates (apply append (make-candidates))])
      (if (null? candidates)
          neighbours
          (let ([neighbour (or (state-horizontal-move (car state)(caar candidates)(cdar candidates))
                               (state-vertical-move (car state)(caar candidates)(cdar candidates)))])
            (if (and neighbour
                     (not (hashtable-contains? seen neighbour)))
                (begin
                  (hashtable-set! seen neighbour #t)
                  (loop (cons (cons neighbour (cons (state-make-move (caar candidates)(cdar candidates)) (cdr state))) neighbours)
                        (cdr candidates)))
                (loop neighbours (cdr candidates)))))))

  (define (make-candidates)
    (map-for position from 1 to 64
             (map-for disp from -4 to 4
                      (cons position disp))))
);close library



