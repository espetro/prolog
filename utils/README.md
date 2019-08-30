## utils

Shortcuts to useful functions, like data structures (list, tree, ..) manipulations, I/O, computations, etc.

### Prolog syntax

Names:
  + Predicate: A.k.a a function.
  + Knowledge Base or *KB*


Here's a list of reminders of how Prolog works, from a eye-view level:
  + `term`: the unique raw datatype. It has multiple subtypes:
    + `numbers`: floats or integers
    + `variables`: Begins with an uppercase or underscore. A single `_` denotes a lambda variable. It can be instantiated within the predicate.
    + `compound terms`: Basically a function (called *functor*) and a set of *arguments*. `Greet(P1, P2)`.
    Moreover, operators can also be defined (as in Haskell) in the same manner, either in *prefix or infix notation*.
    `-(z), =(X,Y), +(a,b)` equals `-z, a+b, X=Y`.
    + `atoms`: Everything else, from underscore strings to upperscored non-variables and the empty list.
    Atoms can be also compound terms of arity 0. `x, blue 'Taco', 'hello world', [], blue()`.

Cool syntax:
  + `.(A,B)` is equivalent to `[A|B]`.
  + ~~A string (characters surrounded by quotes) is equivalent to a list of Unicode characters.~~
  +


#### Unification
Or why with `woman(X)`, `woman(mia)`, *X* is instantiated to *mia*.
