
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
:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% IMPLEMENT THE FOLLOWING PREDICATE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
solve_puzzle(Puzzle, Moves) :-
    puzzle_state(Puzzle, State0),
    once(move_list_gen(State0, Moves)).


% When a solution is found builds an empty list of move objects
move_list_gen(State, []) :-
    state_is_solved(State),!.


move_list_gen(StateN, [MoveN|Moves]) :-
    between(-4, 4, Offset), Offset #\= 0,
    car_pos(StateN, CarPos),
    gen_new_states(StateN, CarPos, Offset, NewStates),
    pos_offset_move(CarPos, Offset, MoveN),
    move_list_gen(NewStates, Moves).

car_pos(StateN, CarPos) :-
    between(0, 63, X),
    findall(X, state_is_end(StateN, X), CarPos).


gen_new_states(StateN, CarPos, Offset, NewState) :-
    horizontal_move(StateN, CarPos, Offset, NewState)
    ;vertical_move(StateN, CarPos, Offset, NewState).


% Solve the puzzle
%solve_puzzle(Puzzle, Moves).
