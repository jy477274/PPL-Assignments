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
      (hashtable-set! seen (state-from-string-rep puzzle) '())
      (let search ([current (list (cons (state-from-string-rep puzzle) '() ))])
        (let* ([next (apply append (for state in current
                                        (moves state seen)))]);                                                                                                
          (for-each println next);next list prints state and move in non-pair form                                                                             
          (for-each println (map cons (build-list next 2 2) (build-list next 1 2))); this appends every second item in next to the one immediately before it, \
;thus forming pairs                                                                                                                                             
          (if (null? next)
              #f
              (for neighbour in (map cons (build-list next 2 2) (build-list next 1 2)) ;for some reason, the pairs arent registering as pairs despite printing\
 ;properly                                                                                                                                                      
                   (if (state-is-solved? (car neighbour))
                       (reverse (cdr neighbour))
                       (search next))))))))



  (define (moves state seen)
    ;(print "In moves \n")                                                                                                                                     
    (let loop ([neighbours '()]
               [candidates (apply append (make-candidates))]) ;are candidates generated each time loop runs?                                                   
      (if (null? candidates); this will never actually be null                                                                                                 
          neighbours
          (let ([neighbour (or (state-horizontal-move (car state)(caar candidates)(cdar candidates))
                               (state-vertical-move (car state) (caar candidates)(cdar candidates)))]);horizontal or vertical moves or neither will succeed he\
;re. if either succeed, keep processing. this may be the best place to filter for seen neighbours or immediately after this in the if statement, as if we conti\
;nue, we will set the neighbour as seen again, even if it has been seen                                                                                         
            (if (and neighbour (not (hashtable-contains? seen neighbour))) ;this should filter seen neighbours out                                             
                (begin
                  (hashtable-set! seen neighbour (cons (state-make-move (caar candidates)(cdar candidates)) (cdr state)));set the neighbour as seen            
                  (loop (cons (cons neighbour (cons (state-make-move (caar candidates)(cdar candidates)) (cdr state))) neighbours)
                        (cdr candidates))) ;([((((neighbour, (move)), state), neighbours))], candidates) is passed back to loop. loops form expects a list of \
;neighbours, and candidates.                                                                                                                                    
                (loop neighbours (cdr candidates)))))));pass back neighbours if neighbour doesnt exist along with the tail of the list of candidates to move o\
;n and process the next candidate.                                                                                                                              

  (define (make-candidates);creates a list of every possible position and offsets associated with them.                                                        
    (map-for position from 1 to 64
             (map-for disp from -4 to 4
                      (cons position disp))))
(define (build-list alphabet count limit) ;used to help rectify the flattened next list in run                                                                 
  (cond ((null? alphabet) '())
        ((= count limit)
         (cons (car alphabet)
               (build-list (cdr alphabet) 1 limit)))
        (else
         (build-list (cdr alphabet) (+ count 1) limit))))
);close library                                                                                                                                                

