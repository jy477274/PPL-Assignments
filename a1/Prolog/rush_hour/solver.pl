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


solve_puzzle(State, Solution):-
    gen_new_states(State, States),
    solve_puzzle(States, Solution).


gen_new_states(State, States):-
    find_cars(State, Cars),
    between(-4, 4, Offset), Offset \= 0,
    horizontal_move(State, Cars, Offset, HStates),
    vertical_move(State, Cars, Offset, VStates),
    append(HStates,VStates, States).


find-cars(State, Cars):-
    between(0, 63, Pos),
    findall(Pos, state_is_end(States, Pos), Cars).


% Solve the puzzle
%solve_puzzle(Puzzle, Moves).


