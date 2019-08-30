% === Exercisis del curs de Logica a la Informatica === %

%% Constant (terms)
% [1,[2,3,4],[5], 6]
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]
% "xamax"

repl(X, N, L) :-
    length(L, N),
    maplist(=(X), L).

% same_reverse/2
same_reverse(L1, L2) :- reverse(L1, L2). % you have to write "L2" not "_" to get it

% my_member/2
my_member(X, [X|_]). % if it goes into this, then evaluates as True.
my_member(X, [_|T]) :- my_member(X, T). % if not the same, jump into the next one

% my_last/2
my_last(X, [X]).
my_last(X, [_|Ys]) :- my_last(X, Ys).

% my_last_but_one/2
my_last_but_one(_, []) :- false.
my_last_but_one(_, [_]) :- false.
my_last_but_one(X, [X|[_]]).
my_last_but_one(X, [_|Ys]) :- my_last_but_one(X, Ys).

% my_elem_at/3
my_elem_at(_, [], _) :- false.
my_elem_at(Y, [Y|_], 0). % 0-based indexing
my_elem_at(X, [_|Ys], K) :- 
    K1 is K - 1,
    my_elem_at(X, Ys, K1).

% my_length/2
%% recursion is done inversely as in Haskell: it takes advantage of Backtracking
my_length(0, []).
my_length(L, [_|Ys]) :-
    my_length(L1, Ys),
    L is L1 + 1.

% This code will be in Haskell - recursion is done in a back-to-front way
%% my_length(L, [_|Xs]) :-
%%     L1 is L + 1,
%%     my_length(L1, Xs).
    
% my_reverse/2
my_reverse([], []).
my_reverse([X], [X]).
my_reverse([X|L1], L2) :- % at some point (base case), L2 becomes []
    my_reverse(L1, L3),
    append(L3, [X], L2). % then you start appending by the tail

% is_palindrome/1
% A word is palindrome if it's spelled the same backwards
is_palindrome([]).
is_palindrome(L) :-
    my_reverse(L, L1),
    L == L1.

% my_flatten/2
my_flatten([], []).
% TODO

% noreps/2
noreps([], []).
noreps([X], [X]).
noreps(Xs, L) :- noreps(Xs, [], L).

% noreps/3 (helper)
noreps([], Ys, L) :- reverse(Ys, L).
noreps([X|Xs], Ys, L) :- 
    member(X, Ys),
    noreps(Xs, Ys, L).
noreps([X|Xs], Ys, L) :-
    \+ member(X, Ys),
    noreps(Xs, [X|Ys], L).

% compress/2
compress([], []).
compress([X], [X]). % mandatory as the check is done 2-by-2
compress([X,X|Xs], Ys) :- compress([X|Xs], Ys).
compress([X,Y|Xs], [X|Ys]) :- compress([Y|Xs], Ys).

% pack/2
% TODO


% dupli/2
dupli([], []).
dupli([X|Xs], [X,X|Ys]) :- dupli(Xs, Ys).

%dupli/3
% base case: if no elements, then empty list
dupli([], _, []).
% backtracking (recursion): replicate N times X, then wait for Ws to backtrack
% until base case, then append all.
dupli([X|Xs], N, Ys) :-
    repl(X, N, Zs),
    dupli(Xs, N, Ws),
    append(Zs, Ws, Ys).

% drop/3
% TODO

% split/4
split([], _, [], []).
split(L0, 0, [], L0). % the rest of L0 is assigned to L2
% this way it takes advantage of backtracking (no 'reverse' needed)
% assigning L1 in the predicate is the same as adding (L1 = [X|L11]) at the end
split([X|L0], N, [X|L11], L2) :- 
    N1 is N - 1,
    split(L0, N1, L11, L2). % backtracking is done previous to the L1 appending

% slice/4
slice(_, 1, 0, []).
slice([X|Xs], 1, N2, [X|L]) :-
    N is N2 - 1,
    slice(Xs, 1, N, L).

slice([_|Xs], N1, N2, L) :-
    NA is N1 - 1,
    NB is N2 - 1,
    slice(Xs, NA, NB, L).

% rotate/3
rotate([], _, []).
% TODO

% remove_at/3
remove_at(_, [], _, []).
remove_at(X, [X|Xs], 1, _) :- remove_at(X, Xs, 0, _).
remove_at(Y, [X|Xs], N, [X|Ys]) :-
    NA is N - 1,
    remove_at(Y, Xs, NA, Ys).
% TODO

% insert_at/4
% The following base case is reduced into the append, as it is forced anyway.
% insert_at(Xnew, [], _, ).
% When Pos is 1, append the n-th+1,2.. elements in the back and assign it to L2
insert_at(Xnew, Xs, 1, L2) :- append([Xnew], Xs, L2).
insert_at(Xnew, [X|Xs], P, [X|L]) :- % The front elements are added when backtracking
    PA is P - 1,
    insert_at(Xnew, Xs, PA, L).

% range/3
range(N,N, [N]). % Base case: same element is a singleton list
range(N, M, [N|L]) :- % the front elements are added while backtracking
    NA is N + 1,
    range(NA, M, L).