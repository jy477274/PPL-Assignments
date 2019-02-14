%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% rush_hour/solver.pl
%
% Rush Hour puzzle solver
% (C) 2019 Norbert Zeh (nzeh@cs.dal.ca)
%
% The solver logic
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Import the state predicates
:- [rush_hour/state].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% IMPLEMENT THE FOLLOWING PREDICATE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
puzzle_solution(Puzzle, Solution) :-
  puzzle_state(Puzzle, State),
  solve_puzzle(State, Solution).
  
solve_puzzle(State, Solution) :- % Driver pred for puzzle_solution, not sure if I need it but my head will explode if I try to be too "elegant"
  valid_pos(State, Pos),
  possible_moves(State, Pos, Moves),
  once(findall(Moves, state_is_solved(first(Moves), Solution))) ->.
  
valid_pos(State, VPos) :- % Gens all possible car rightmost/bottom cell locations, retruns the list of values Vpos
  between(0, 63, X),
  findall(X, state_is_occupied(State, X), Occ),
  findall(Occ, state_is_end(State, X), VPos).
 
possible_moves(State, Pos, VMoves) :- % Splits this bad boi into two lists containing horiz and virt cars. gens lists of all possible moves 
  findall(Pos, state_is_horizontal(State, Pos), HCars), %then merges the lists into a giant valid moves lists containing newStates and the lists of moves
  findall(Pos, state_is_vertical(State, Pos), VCars),
  hor_list()
  virt_list()
  
% Basically I"m at the point where I don't know how to match the new states that I'm generating to the moves, (that I need
% for an actual solution.) I'm planning on storing this info into nested lists or sets, possibly using setof. I also need
% make sure I'm storing the values correctly. I think this way: list<-(STATE, (list of moves, head of which is the most recent move))
% I don't really know how I should go about doing it. Need to ask Alex/Norbert.




hor_list(State, Pos, NewState) :-
  between(-4, 4, Off),
  findall(Off, horizontal_move(State, Pos, Off, NewStates), NewStates (,add(move)),

virt_list(State, Pos, NewState) :- 

% Solve the puzzle
%solve_puzzle(Puzzle, Moves).
