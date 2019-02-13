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
  (define (makelist start end)
    (if (<= start end)
        (cons start (makelist (+ start 1) end))
        '())
    (define startstate (state-from-string-rep puzzle))
    (let* (
          [current (list (list '() startstate))]
          [next (list '())]
          [seen (make-eqv-hashtable)])
          ;(print startstate)

          (hashtable-set! seen startstate #t)

          (begin (run seen current next))))

  (define (run seen current next)
    (print "In run \n")
    (for state in current
         ;(print (cdr state)) ;mf prints a mf string
         (let* ([neighbours (moves (cadr state))])
           (print "move generation successful \n")
           ;check if neighbours is empty -> no solution if empty
           (if (null? neighbours)
               #f  ;no solution
               ((for neighbour in neighbours
                    (print neighbour)
                    (print "\n")
                     (cond [(not(hashtable-contains? seen (neighbour))) ;removed car neighbour
                            (hashtable-set! seen (neighbour) #t) ;removed car neighbour
                            (cons neighbour next)]

                           ;print solution moves
                           [(state-is-solved? (car neighbour))
                            (for-each println (reverse (cdr neighbour)))]

                           [else (run seen next '())])))))))


  (define (moves state)
    (print "In moves \n")
    (print state)
    (let*([position (makelist 64 '0)] ;need make-list func
          [disp '(-4 -3 -2 -1 1 2 3 4)])
      (begin
        ;(filter
          ;(lambda(value) value) ;remove all #f values
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

                        (filter (lambda (pos) (state-is-end? state pos)) position))))))));close library


