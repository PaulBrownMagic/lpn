:- object('1',
    extends(chapter)).
    title("Facts, Rules, and Queries").
    children(['1.1', '1.2', '1.3', '1.4']).
    goals(["To give some simple examples of Prolog programs. This will introduce us to the three basic constructs in Prolog: facts, rules, and queries. It will also introduce us to a number of other themes, like the role of logic in Prolog, and the idea of performing unification with the aid of variables."
          , "To begin the systematic study of Prolog by defining terms, atoms, variables and other syntactic concepts."
          ]).
:- end_object.

:- object('2',
    extends(chapter)).
    title('Unification and Proof Search').
    children(['2.1', '2.2', '2.3', '2.4']).
    goals(["To discuss unification in Prolog, and to explain how Prolog unification differs from standard unification. Along the way, we'll introduce =/2, the built-in predicate for Prolog unification, and unify_with_occurs_check/2, the built in predicate for standard unification"
          , "To explain the search strategy Prolog uses when it tries to deduce new information from old using modus ponens"
          ]).
:- end_object.
