
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
    (let* ([startstate (state-from-string-rep puzzle)]
          [current (list '(startstate '() ))]
          [next '()]
          [seen (make-eqv-hashtable)])

          (hashtable-set! seen startstate #t)

          (begin (run startstate seen current next))))

  (define (run seen current next)
    (for (state) in current
         (let* ([neighbours (moves (car state))])
           (for (neighbour) in neighbours
                ;if neighbours is empty then WE FUCKED UP
                (cond [(not(hashtable-contains? seen (car neighbour)))
                       (hashtable-set! seen (car neighbour))
                       (cons neighbour next)]
                      ;check if this neighbour is a solution. if so then print)
                )))
         );call (run seen next)

  (define (check-solution statelist)
    (if (null? statelist) #f) ;no solution found -> return false
    (if (state-is-solved? (car statelist))
        (car statelist)
        (check-solution (car statelist))))

