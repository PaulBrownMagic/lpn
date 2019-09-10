:- object('2.3', extends(exercises)).
    children(['2.3.1', '2.3.2', '2.3.3', '2.3.4', '2.3.5', '2.3.6', '2.3.7']).
:- end_object.


:- object('2.3.1', extends(mcq)).
    title("Unification Success and Failure").
    question_options([unifies, fails]).
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

    subcontent(p("Which of the following pairs of terms unify?")).
:- end_object.


:- object('2.3.2', extends(input_markscheme_quiz)).
    title("Unification With Variables").
    questions([ question('Bread = bread',                               'Bread = bread'                   )
              , question('food(bread) = X',                             'X = food(bread)'                 )
              , question('food(X) = food(bread)',                       'X = bread'                       )
              , question('food(bread, X) = food(Y, sausage)',           'X = sausage, Y = bread'          )
              , question('food(X) = X',                                 'X = food(X)'                     )
              , question('meal(food(bread), drink(beer)) = meal(X, Y)', 'X = food(bread), Y = drink(beer)')
              ]).

    markscheme([p("When unifying variables Prolog will print the variable first. A variable will unify with anything. Those in complex terms unify with atoms in the matching positions of the same predicate with the same arity. Once a variable is unified it can't be instantiated to a different value in the same expression."), p(["In the case of ", \inline_code("X = food(X)"), ", according to the basic definition of unification given in the text, these two terms do not unify, as no matter what (finite) term we instantiate ", \inline_code("X"), " to, the two sides won't be identical. However (as we mentioned in the text) modern Prolog interpreters will detect that there is a problem here and will instantiate ", \inline_code("X"), " with the 'infinite term' ", \inline_code("food(food(food(...))),"), " and report that unification succeeds. In short, there is no 'correct' answer to this question; it's essentially a matter of convention. The important point is to understand why such unifications need to be handled with care."])]).
    subcontent(p("Give the variable instantiations that lead to successful unification, in the format: Var = term")).
:- end_object.


:- object('2.3.3', extends(mcq)).
    title("Unification Through Rules, Success and Failure").
    question_options([succeeds, fails]).
     questions([ question('?- magic(house_elf).', fails, 'Prolog cannot unify X with a functor')
              , question('?- wizard(harry).', fails, 'Prolog cannot unify X with something not in the knowledge base')
              , question('?- magic(wizard).', fails, 'Prolog cannot unify X with something not in the knowledge base')
              , question('?- magic(\'McGonagall\').', succeeds, 'Prolog can unify X via the goal complex term by looking up a fact')
              , question('?- magic(Hermione).', succeeds, 'Hermione is a variable')
              ]).

    subcontent(
        [ p("We are working with the following knowledge base:")
        , \static_code_block(
            [ "house_elf(dobby)."
            , "witch(hermione)."
            , "witch(’McGonagall’)."
            , "witch(rita_skeeter)."
            , "magic(X):-  house_elf(X)."
            , "magic(X):-  wizard(X)."
            , "magic(X):-  witch(X)."
            ])
        , p("Which of the following queries are satisfied?")
        ]).
:- end_object.


:- object('2.3.4', extends(input_compare_quiz)).
    title("Unification Order Through Rules"). % In what order do these unify).
    questions([ question('Hermione = dobby.',         '1', 'Prolog checks rules from top to bottom')
              , question('Hermione = house_elf',       '', 'Prolog cannot unify X with a functor')
              , question('Hermione = hermione',       '2', 'Prolog checks facts from top to bottom')
              , question('Hermione = rita_skeeter',   '4', 'Prolog checks facts from top to bottom')
              , question('Hermione = \'McGonagall\'', '3', 'Prolog checks facts from top to bottom')
              ]).

    subcontent(
        [ p("We are working with the following knowledge base:")
        , \static_code_block(
            [ "house_elf(dobby)."
            , "witch(hermione)."
            , "witch(’McGonagall’)."
            , "witch(rita_skeeter)."
            , "magic(X):-  house_elf(X)."
            , "magic(X):-  wizard(X)."
            , "magic(X):-  witch(X)."
            ])
        , p("In what order are these variable instantiations returned? Give the number 'eg. 1' or leave it blank if it's not returned")
        ]).
:- end_object.


:- object('2.3.5', extends(offline_markscheme_quiz)).

    title("Unification Proof Tree").

    subcontent(
        [ p("We are working with the following knowledge base:")
        , \static_code_block(
            [ "house_elf(dobby)."
            , "witch(hermione)."
            , "witch(’McGonagall’)."
            , "witch(rita_skeeter)."
            , "magic(X):-  house_elf(X)."
            , "magic(X):-  wizard(X)."
            , "magic(X):-  witch(X)."
            ])
            , p(["Draw the search tree for the query ", \inline_code("?- magic(Hermione).")])
        ]).

    markscheme([p(["The search tree for the query ", \inline_code("magic(Hermione)"), " is:"]), \diagram("chapter2/answer235.png", "Search tree for the query `magic(Hermione)`")]).

:- end_object.


:- object('2.3.6',
    extends(input_markscheme_quiz)).
    title("Generation By Unification").
    questions([ question('1', 'a criminal eats a criminal')
              , question('2', 'a criminal eats a big kahuna burger')
              , question('3', 'a criminal likes a criminal')
              , question('4', 'a criminal likes a big kahuna burger')
              , question('5', 'a big kahuna burger eats a criminal')
              , question('6', 'a big kahuna burger eats a big kahuna burger')
              , question('7', 'a big kahuna burger likes a criminal')
              , question('8', 'a big kahuna burger likes a big kahuna burger')
              ]).

    markscheme(p("Prolog unifies with rules and facts from top to bottom, but backtracks goals from bottom to top.")).
    subcontent([ p("Here is a tiny lexicon (that is, information about individual words) and a mini grammar consisting of one syntactic rule (which defines a sentence to be an entity consisting of five words in the following order: a determiner, a noun, a verb, a determiner, a noun).")
               , \static_code_block(
                   [ "word(determiner,a)."
                   , "word(noun,criminal)."
                   , "word(noun,’big  kahuna  burger’)."
                   , "word(verb,eats)."
                   , "word(verb,likes)."
                   , ""
                   , "sentence(Word1,Word2,Word3,Word4,Word5):-"
                   , "      word(determiner,Word1),"
                   , "      word(noun,Word2),"
                   , "      word(verb,Word3),"
                   , "      word(determiner,Word4),"
                   , "      word(noun,Word5)."
                   ])
              , p(["List all sentences that this grammar can generate in the order that Prolog will generate them in."])
              , p("Note: the auto-marker expects the format: a criminal eats a criminal")
              ]
          ).
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
        [ p(["Here are six Italian words:"])
        , p(em("astante, astoria, baratto, cobalto, pistola, statale."))
        , p(["They are to be arranged, crossword puzzle fashion, in the following grid:"])
        , \diagram("chapter2/grid.png", "Crossword Grid")
        , p(["The following knowledge base represents a lexicon containing these words:"])
        , \static_code_block(
            [ "word(astante,  a,s,t,a,n,t,e)."
            , "word(astoria,  a,s,t,o,r,i,a)."
            , "word(baratto,  b,a,r,a,t,t,o)."
            , "word(cobalto,  c,o,b,a,l,t,o)."
            , "word(pistola,  p,i,s,t,o,l,a)."
            , "word(statale,  s,t,a,t,a,l,e)."
            ])
        , p(["Write a predicate ", \inline_code("crossword/6"), " that tells us how to fill in the grid. The first three arguments should be the vertical words from left to right, and the last three arguments the horizontal words from top to bottom. "])
        ]).
:- end_object.
