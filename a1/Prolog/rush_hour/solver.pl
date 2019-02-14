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
  
solve_puzzle(State, Solution) :-
  valid_pos(State, Pos),
  possible_moves(State, Pos, Moves),
  once(findall(Moves, state_is_solved(first(Moves), Solution))) ->.
  
valid_pos(State, VPos) :-% Gens all possible car rightmost/bottom cell locations, retruns the list of values Vpos
  between(0, 63, X),
  findall(X, state_is_occupied(State, X), Occ),
  findall(Occ, state_is_end(State, X), VPos).
  

possible_moves(State, Pos, VMoves) :-

  
  
    
 
 
 
 valid_pos(X, ,Pos) :-
   findall(Pos, state_is_occupied(State, X), Rs),
   findAll(Rs, state_is_end(State, Rs), Pos).
  



%for(i=0; i<64, i++)
% state_is_horizontal(State, i)
%  state_is_end(State, i) - check if the square is part of a horizontal car, if its the end of that car
%	for(j=1, j<5, j++)
%    horizontal_move(State, i, j, NewState)  -- on success, where do we put NewState (in _next and _seen list?)
%	for(j=-1, j>-5, j--)
%	 horizontal_move(State, i, j, NewState)
% state_is_vertical(State, i)
%  state_is_end(State, i)
%	for(j=1, j<5, j++)
%    vertical_move(State, i, j, NewState)  -- on success, where do we put NewState (in _next and _seen list?)
%	for(j=-1, j>-5, j--)
%	 vertical_move(State, i, j, NewState)

% check current/next list using state_is_solved(State) to look for solution - print sol and exit if true
% else call solve_puzzle with state in _next and set _current list to _next list and wipe _next
% 

% Solve the puzzle
%solve_puzzle(Puzzle, Moves).
