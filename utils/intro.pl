% = LOAD DB = run '[intro].' %

% infix notation: "Romeo loves Juliet"
% prefix notation, "loves Romeo Juliet"
loves(romeo, juliet).

% Albert 
% Juliet loves Romeo IF Romeo loves Juliet
loves(juliet, romeo) :- loves(romeo, juliet).

male(albert).
male(bob).
male(dan).

% if you query "female(X)." it will show you just "female(alice)"
% to cycle throughout all the options type ';'
female(alice).
female(betsy).

% A person cums IF the person is also male
cums(X) :- male(X).

happy(bill).
happy(john).

% swims only is defined for "bill". Others will yield "false"
swims(bill) :-
    happy(bill).

% if we use an undefined procedure, a "ERROR: undefined procedure" will pop
% however this is not checked at compile time by Prolog.
swims(bill) :-
    happy(bill),
    near_water(bill).

% if you keep pressing ";", a "no" will appear at some point, meaning that
parent(albert, bob).
parent(albert, john).
parent(albert, bill).

parent(alice, bob).
parent(alice, john).
parent(alice, bill).

parent(bob, carl).
parent(bob, charlie).

% Get's the grandchild given the grandparent
get_grandchild1(Grandfather) :-
    parent(Grandfather, X),
    parent(X, Y),
    write("Albert's grandchild is "),
    write(Y), nl.

% This does the same as the previous one but uses I/O formatting
get_grandchild2(Grandfather) :-
    parent(Grandfather, X),
    parent(X, Y),
    format("~w's grandchild is ~w ~n", [Grandfather, Y]).

% X is the grand_parent of Y
grand_parent(X, Y) :-
    parent(Z, Y),
    parent(X, Z).

% querying Prolog with an underscore / lambda predicate (eg 'male(_)')
% only yields if there's such a condition (just returns true's or false's).

% ========= %
warm_blooded(penguin).
warm_blooded(human).

produce_milk(penguin).
produce_milk(human).

have_feathers(penguin).
have_hair(human).

% run it with "trace.", then "mammal(human)." then "mammal(penguin)."
% to see how the rule-checking process works. Then "notrace."
mammal(X) :-
    warm_blooded(X),
    produce_milk(X),
    have_hair(X).


% === RECURSION === %
% this is similar to a function in Haskell
related(X, Y) :- parent(X, Y).
related(X, Y) :- 
    parent(Z, Y),
    parent(X, Z).
% another way is to define a set of simple rules (for parent, brothers, ..)
% then add this one (which searches for further relationships, no matter they
% are parenthood, brotherhood-based).
related(X, Y) :- 
    parent(Z, Y),
    related(Z, X).

% negation is '\+'
% \+ (3 = 10)

% equality is '=:='
% inequality is '=\='
% OR operator is ';'
% AND operator is ','

% temporal "assignment" operator (similar to Haskell's) is "A is B"
% remember there can't be space among operators (X*2 NOT X * 2)
% double_digit(1000, Y).
double_digit(X, Y) :-
    Y is X*2.


% === PREDEFINED PREDICATES === %
% random(0, 10, X).
% between(0, 10, X).
% succ(2, X).
% X is abs(-8).
% X is max(10,5).
% round(10.1235). also floor(), truncate(), ceiling()
% division, float (/) or integer (//).

% show quotes writeq()
% read from CLI into variable read(X). You have to input it "like this"
say_hi :-
    write("What's your name? "),
    read(X),
    format("'Hi ~w'", [X]).

% The character doesn't need to be between quotes
fav_char :-
    write("Write your fav char: "),
    get(X),
    format("Its ASCII value is ~w (", [X]),
    put(X), write(")"), nl.

write_to_file(File, Text) :-
    open(File, write, Stream),
    write(Stream, Text), nl,
    close(Stream).

read_from_file(File) :-
    open(File, read, Stream),
    get_char(Stream, Char1),
    process_stream(Char1, Stream),
    close(Stream).

% 'end_of_file' is a safe kw in Prolog equivalent to \EOF
% Use a cut ('!'), which cuts the backtracking (basically stops the execution
% / search of that branch).
process_stream(end_of_file, _) :- !.
process_stream(Char, Stream) :-
    write(Char), 
    get_char(Stream, Char2),
    process_stream(Char2, Stream).

% recursive programming like in Haskell
count_to_10(10) :- write(10), nl.
count_to_10(X) :-
    write(X), nl,
    Y is X + 1,
    count_to_10(Y).

count_down(Low, High) :-
    between(Low, High, Y), % count from a to b [a,b]
    Z is High - (Y - Low + 1), % make the count inverse [b,a]
    write(Z), nl.

count_up(Low, High) :- 
    between(Low, High, X),
    write(X), nl.

% You can mark predicates as non-constants with the kw 'dynamic'.
:- dynamic(father/2). % a predicate that takes two arguments
:- dynamic(likes/2).
:- dynamic(friends/2).
:- dynamic(stabs/3).

father(john, billie).
father(john, carl).

likes(carl, dancing).
likes(john, drive).

% 'assert' allows to append data to the KB in the runtime
% assert(father(john, bill)).
% 'retract' is a runtime-based method to remove data from the KB.
% retract(father(john, bill)).
% 'retractall' applies 'retract' to all predicates that match the condition
% retractall(likes(_, dancing)).

% [_, X2, _, _|T] = [a,b,c,d]
% [_, X2, _, _, T] = [a,b,c,d] is wrong
% [_, _, [X|Y], _, Z|T] = [a,b, [c,d,e], f,g,h]
% [_, _, [X|_|_|Y], _, Z|T] = [a,b, [c,d,e], f,g,h] is wrong (cannot use 2 _ in a row)

% List1 = [a,b,c].
% member(a, List1). checks if a term (aka an atom) is in a list

% member(X, [a,b,c,d]). checks which atoms are in the list

% reverse([1,2,3,4,5], X). assigns the reversed list to X
% append([1], [4,5,6], X). assigns the combined list to X

write_list([]).
write_list([Head|Tail]) :-
    write(Head), nl,
    write_list(Tail).

% name(str, X). gets the ASCII numbers from each char of the string
% name(X, charr). gets the string from the list of ASCII numbers.
join_str(Str1, Str2, Str3) :-
    name(Str1, StrList1),
    name(Str2, StrList2),
    append(StrList1, StrList2, StrList3),
    name(Str3, StrList3).

% gets the charr from "Derek" -> List, gets the 1st char -> FChar,
% FChar is casted to a char again
% name("Derek", List), nth0(0, List, FChar), put(FChar)

%% == WHAT TO SEEK FOR (IMPROVE) == %%
% 1. double-reference: name("hello", XX), name(X, XX).
% 2. output-as-argument: get_char(Stream, Char2) where Char2 is piped
% 3. Loop efficiency: if is ':-', while/for repeats the condition + recursion,
%    how to do mapping / filtering / reducing?
% 4. Functional programming / Higher-order programming in Prolog. Advantageous?
% 5. Haskell-like lists / DS : time complexity + optimization?
% 6. Querying in a logical way: related(X, carl) OR related(X, related(_, carl))
% 7. Format strings in order to save/reuse them? Not just output
% 8. Review in Theory: Unification, Backtracking, Cuts, Pattern-Matching

/** Multiline
 * comment
 * **/
