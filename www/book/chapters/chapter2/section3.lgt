:- object('2.3',
    extends(exercises)).
    children(['2.3.1', '2.3.2', '2.3.3', '2.3.4', '2.3.5', '2.3.6', '2.3.7']).
:- end_object.


:- object('2.3.1',
    extends(mcq)).
    title("Unification Success and Failure").
    question_opts([unifies, fails]).
    questions([ question('bread = bread', unifies, 'unification succeeds when both sides of = are identical')
              , question('\'Bread\' = bread', fails, 'atoms must be absolutely identical, ignoring single quotation marks (\'), for unification to succeed')
              , question('\'bread\' = bread', unifies, 'atoms must be absolutely identical, ignoring single quotation marks (\'), for unification to succeed')
              , question('Bread = bread', unifies, 'a variable will unify with anything')
              , question('bread = sausage', fails, 'atoms must be absolutely identical, ignoring single quotation marks (\'), for unification to succeed')
              , question('food(bread) = bread', fails, 'a complex term is not identical to a variable and cannot unify with it')
              , question('food(bread) = X', unifies, 'a variable will unify with anything')
              , question('food(X) = food(bread)', unifies, 'variables in complex terms will unify with atoms in matching positions of the same predicate')
              , question('food(bread, X) = food(Y, sausage)', unifies, 'variables in complex terms will unify with atoms in matching positions of the same predicate')
              , question('food(bread, X, beer) = food(Y, sausage, X)', fails, 'variables unify across the whole expression and cannot unify with two different atoms')
              , question('food(bread, X, beer) = food(Y, kahuna_burger)', fails, 'Prolog can only unify across complex terms if they have the same functor and arity')
              , question('food(X) = X', unifies, 'according to the basic definition of unification given in the text, these two terms do not unify, as no matter what (finite) term we instantiate X to, the two sides won\'t be identical. However (as we mentioned in the text) modern Prolog interpreters will detect that there is a problem here and will instantiate X with the \'infinite term\' food(food(food(...))), and report that unification succeeds. In short, there is no \'correct\' answer to this question; it\'s essentially a matter of convention. The important point is to understand why such unifications need to be handled with care.')
              , question('meal(food(bread), drink(beer)) = meal(X, Y)', unifies, 'variables in complex terms will unify with complex terms in matching positions of the same predicate')
              , question('meal(food(bread), X) = meal(X, drink(beer))', fails, 'variables unify across the whole expression and cannot unify with two different complex terms')
              ]).

    subcontent(p("Which of the following sequences of characters are atoms, which are variables, and which are neither?")).
:- end_object.


:- object('2.3.2',
    extends(input_compare_quiz)).
    title("Unification With Variables").
    questions([ question('Bread = bread', 'Bread = bread', 'a variable will unify with anything')
              , question('food(bread) = X', 'X = food(bread)', 'a variable will unify with anything')
              , question('food(X) = food(bread)', 'X = bread', 'variables in complex terms will unify with atoms in matching positions of the same predicate')
              , question('food(bread, X) = food(Y, sausage)', 'X = sausage, Y = bread', 'variables in complex terms will unify with atoms in matching positions of the same predicate')
              , question('food(X) = X', 'X = food(X)', 'according to the basic definition of unification given in the text, these two terms do not unify, as no matter what (finite) term we instantiate X to, the two sides won\'t be identical. However (as we mentioned in the text) modern Prolog interpreters will detect that there is a problem here and will instantiate X with the \'infinite term\' food(food(food(...))), and report that unification succeeds. In short, there is no \'correct\' answer to this question; it\'s essentially a matter of convention. The important point is to understand why such unifications need to be handled with care.')
              , question('meal(food(bread), drink(beer)) = meal(X, Y)', 'X = food(bread), Y = drink(beer)', 'variables in complex terms will unify with complex terms in matching positions of the same predicate')
              ]).

    subcontent(p("Which of the following sequences of characters are atoms, which are variables, which are complex terms, and which are not terms at all?")).
:- end_object.


:- object('2.3.3',
    extends(mcq)).
    title("Unification Through Rules, Success and Failure").
    question_options([succeeds, fails]).
     questions([ question('?- magic(house_elf).', fails, 'Prolog cannot unify X with a functor')
              , question('?- wizard(harry).', fails, 'Prolog cannot unify X with something not in the knowledge base')
              , question('?- magic(wizard).', fails, 'Prolog cannot unify X with something not in the knowledge base')
              , question('?- magic(\'McGonagall\').', succeeds, 'Prolog can unify X via the goal complex term by looking up a fact')
              , question('?- magic(Hermione).', succeeds, 'Hermione is a variable')
              ]).

    subcontent(
        [ p("What is the functor and arity of each of these complex terms?")
        , p([em("Remember: functor and arity is written as "), \inline_code("functor/arity")])
        ]).
:- end_object.


:- object('2.3.4',
    extends(input_compare_quiz)).
    title("Unification Order Through Rules" % In what order do these unify).
    questions([ question('Hermione = dobby.', '1', 'Prolog checks rules from top to bottom')
              , question('Hermione = house_elf', '', 'Prolog cannot unify X with a functor')
              , question('Hermione = hermione', '2', 'Prolog checks facts from top to bottom')
              , question('Hermione = rita_skeeter', '4', 'Prolog checks facts from top to bottom')
              , question('Hermione = \'McGonagall\'', '3', 'Prolog checks facts from top to bottom')
              ]).

    subcontent(
        [ p("How many facts, rules, clauses and predicates are there in the following knowledge base?")
        , \static_code_block(
'woman(vincent).
woman(mia).
man(jules).
person(X) :- man(X) ; woman(X).
loves(X, Y) :- father(X, Y).
father(Y, Z) :- man(Y) , son(Z, Y).
father(Y, Z) :- man(Y), daughter(Z, Y).')
        ]).
:- end_object.


:- object('2.3.5',
    extends(leaf_section)).

    title("Unification Proof Tree").

    subcontent(
        [ p("Identify the heads, bodies and goals in the following knowledge base.")
        , \static_code_block(
'woman(vincent).
woman(mia).
man(jules).
person(X) :- man(X) ; woman(X).
loves(X, Y) :- father(X, Y).
father(Y, Z) :- man(Y) , son(Z, Y).
father(Y, Z) :- man(Y), daughter(Z, Y).')
        ]).
:- end_object.


:- object('2.3.6',
    extends(input_markscheme_quiz)).
    title("Generation By Unification").
    questions([ question('1', 'a criminal eats a criminal')
              , question('2', 'a criminal eats a big kahuna burger')
              , question('3', 'a criminal eats every criminal')
              , question('4', 'a criminal eats every big kahuna burger')
              , question('5', 'a criminal likes a criminal')
              , question('6', 'a criminal likes a big kahuna burger')
              , question('7', 'a criminal likes every criminal')
              , question('8', 'a criminal likes every big kahuna burger')
              , question('9', 'a big kahuna burger eats a criminal')
              , question('10', 'a big kahuna burger eats a big kahuna burger')
              , question('11', 'a big kahuna burger eats every criminal')
              , question('12', 'a big kahuna burger eats every big kahuna burger')
              , question('13', 'a big kahuna burger likes a criminal')
              , question('14', 'a big kahuna burger likes a big kahuna burger')
              , question('15', 'a big kahuna burger likes every criminal')
              , question('16', 'a big kahuna burger likes every big kahuna burger')
              , question('17', 'every criminal eats a criminal')
              , question('18', 'every criminal eats a big kahuna burger')
              , question('19', 'every criminal eats every criminal')
              , question('20', 'every criminal eats every big kahuna burger')
              , question('21', 'every criminal likes a criminal')
              , question('22', 'every criminal likes a big kahuna burger')
              , question('23', 'every criminal likes every criminal')
              , question('24', 'every criminal likes every big kahuna burger')
              , question('25', 'every big kahuna burger eats a criminal')
              , question('26', 'every big kahuna burger eats a big kahuna burger')
              , question('27', 'every big kahuna burger eats every criminal')
              , question('28', 'every big kahuna burger eats every big kahuna burger')
              , question('29', 'every big kahuna burger likes a criminal')
              , question('30', 'every big kahuna burger likes a big kahuna burger')
              , question('31', 'every big kahuna burger likes every criminal')
              , question('32', 'every big kahuna burger likes every big kahuna burger')
              ]).

    markscheme(["Here is an example of what your answers could look like.  They, of course, don't have to look ", em("exactly"), " like that. For example, the first fact could also be ", \inline_code("killer('Butch')"), " or ", \inline_code("killer(b)"), " or even ", \inline_code("k(50)"), ", if you decide to represent Butch by the number 50 and the property of being a killer by the predicate ", \inline_code("k/1"), "."]).
    subcontent(p("Represent the following in Prolog:")).
:- end_object.


:- object('2.3.7',
    extends(leaf_section)).
    title("Crossword Puzzle").
    tests([ test('current_predicate(/(crossword, 6)).', 'You need to define a predicate \'crossword/6\' ')
          , test('crossword(astante, cobalto, pistola, _, _, _).', 'The first three arguments should be the vertical words from left to right')
          , test('crossword(astoria, baratto, statale, _, _, _).', 'The first three arguments should be the vertical words from left to right')
          , test('crossword(_, _, _, astoria, baratto, statale).', 'The second three arguments should be the horizontal words from top to bottom')
          , test('crossword(_, _, _, astante, cobalto, pistola).', 'The second three arguments should be the horizontal words from top to bottom')
          , test('crossword(A, B, C, D, E, F), A \\= D, B \\= E, D \\= F, \\+ crossword(A, B, C, A, B, C).', 'All six words should be unified')
          ]).
    results([ result('crossword(astante, cobalto, pistola, astoria, baratto, statale).')
            , result('crossword(astoria, baratto, statale, astante, cobalto, pistola).')
            ]).
    example_solution(
'crossword(V1, V2, V3, H1, H2, H3):-
    word(V1, _, A, _, B, _, C, _),
    word(V2, _, D, _, E, _, F, _),
    word(V3, _, G, _, H, _, I, _),
    word(H1, _, A, _, D, _, G, _),
    word(H2, _, B, _, E, _, H, _),
    word(H3, _, C, _, F, _, I, _),
    V1 \\= H1, V2 \\= H2, V3 \\= H3.').

    subcontent(
        [ p("Suppose we are working with the following knowledge base:")
        , \static_code_block(
'wizard(ron).
hasWand(harry).
quidditchPlayer(harry).
wizard(X) :- hasBroom(X), hasWand(X).
hasBroom(X) :- quidditchPlayer(X).
')
        , p("How does Prolog respond to the following queries?")
        ]).
:- end_object.
