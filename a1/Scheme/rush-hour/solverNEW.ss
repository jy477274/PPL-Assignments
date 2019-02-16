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
           [current (cons (cons startstate (list '('start))) '())]
           [next (list '())]
           [seen (make-eqv-hashtable)])
           (print startstate)
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
        (run seen next '()))) ;may need a begin here but not sure

  ;The meat that uses moves to generate neighbours to each state in current.
  ;If they haven't been seen add to seen and next lists.
  ;Check if solution and just print and exit.
  (define (sol-search seen current next)
    (print "In sol-state \n")
    (begin
      (for state in current
           (let* ([neighbours (moves (car state))])
              (print "Neighbours from moves: \n")
              ;(for-each println neighbours)
              (for neighbour in neighbours
                   (cond [(state-is-solved? (car neighbour)) ;may need to change car depending on moves
                          (begin
                            (for-each println (reverse (cdr neighbour))) ;may need to change cdr
                            (exit))]

                         [(not(hashtable-contains? seen (car neighbour))) ;may need to change car
                          (begin
                           ;cons state's moves onto neighbour before adding to next
                            (set! next (append next (cons (car neighbour) (cons (cdr neighbour)(cdr state)))))
                            (hashtable-set! seen (car neighbour) #t))]))))
      (print "Next list: \n")
      (for-each println next)
      (if (null? next)
          '()
          next)))


  (define (moves state)
    (print "In moves \n")
    (let loop ([neighbours '()]
               [candidates (apply append (make-candidates))])
      (if (null? candidates)
          neighbours
          (let ([neighbour (or (state-horizontal-move state (caar candidates)(cdar candidates))
                               (state-vertical-move state (caar candidates)(cdar candidates)))])
            (if neighbour
                (loop (cons (cons neighbour (state-make-move (caar candidates)(cdar candidates))) neighbours)
                      (cdr candidates))
                (loop neighbours (cdr candidates)))))))

  (define (make-candidates)
    (map-for position from 1 to 64
             (map-for disp from -4 to 4
                      (cons position disp))))
);close library



