:- object('4.4', extends(exercises)).
    children(['4.3.1', '4.3.2', '4.3.3', '4.3.4', '4.3.5', '4.3.6', '4.3.7', '4.3.8']).
:- end_object.


:- object('4.3.1', extends(mcq)).
    title("Unification with lists").
    question_options([yes, no]).
    questions([ question('[a, b, c, d] = [a, [b, c, d]].', no, 'the lists must have the same number of elements to unify')
              , question('[a, b, c, d] = [a|[b, c, d]].', yes, 'the | operator distinguishes the head from the tail')
              , question('[a, b, c, d] = [a, b, [c, d]].', no, 'the lists must have the same number of elements to unify')
              , question('[a, b, c, d] = [a, b|[c, d]].', yes, 'the | operator distinguishes the head from the tail')
              , question('[a, b, c, d] = [a, b, c, [d]].', no, 'the lists must have the same number of elements to unify')
              , question('[a, b, c, d] = [a, b, c|[d]].', yes, 'the | operator distinguishes the head from the tail')
              , question('[a, b, c, d] = [a, b, c, d, []].', no, 'the lists must have the same number of elements to unify')
              , question('[a, b, c, d] = [a, b, c, d|[]].', yes, 'the | operator distinguishes the head from the tail')
              , question('[] = _.', yes, 'the empty list unifies with the anonymous variable')
              , question('[] = [_].', no, 'the lists must have the same number of elements to unify')
              , question('[] = [_|[]].', no, 'the lists must have the same number of elements to unify')
              ]).
    subcontent(p("How does Prolog respond to the following queries?")).
:- end_object.



:- object('4.3.2', extends(mcq)).
    title("List Syntax").
    question_options([correct, incorrect]).
    questions([ question('[1|[2, 3, 4]]', correct, 'the | operator is preceeded by individual elements and followed by a list')
              , question('[1, 2, 3|[]]', correct, 'the | operator is preceeded by individual elements and followed by a list')
              , question('[1|2, 3, 4]', incorrect, 'the tail must be a list')
              , question('[1|[2|[3|[4]]]]', correct, 'the | operator can be nested')
              , question('[1, 2, 3, 4|[]]', correct, 'the | operator is preceeded by individual elements and followed by a list')
              , question('[[]|[]]', correct, 'the | operator is preceeded by individual elements and followed by a list')
              , question('[[1, 2]|4]', incorrect, 'the tail must be a list')
              , question('[[1, 2], [3, 4]|[5, 6, 7]]', correct, 'the | operator is preceeded by individual elements (including lists) and followed by a list')
              ]).
    subcontent(p("Which of the following are syntactically correct lists?")).
:- end_object.



:- object('4.3.3', extends(input_compare_quiz)).
    title("List Element Count").
    question_options([correct, incorrect]).
    questions([ question('[1|[2, 3, 4]]', '4', 'the list is [1, 2, 3, 4]')
              , question('[1, 2, 3|[]]', '3', 'the list is [1, 2, 3]')
              , question('[1|[2|[3|[4]]]]', '4', 'the list is [1, 2, 3, 4]')
              , question('[1, 2, 3, 4|[]]', '4', 'the list is [1, 2, 3, 4]')
              , question('[[]|[]]', '1', 'the list is [[]], a list containing the empty list')
              , question('[[1, 2], [3, 4]|[5, 6, 7]]', '5', 'the list is [[1, 2], [3, 4], 5, 6, 7]')
              ]).
    subcontent(p("How many elements does each list have?")).
:- end_object.



:- object('4.3.4', extends(predicate_quiz)).
    title("Second Predicate"). % In what order do these unify).

    subcontent(
        [ p(["Write a predicate ", \inline_code("second(X, List)"), " which checks whether ", \inline_code("X"), " is the second element of ", \inline_code("List"), "."])
        ]).

    tests(
        [ "second(X, [_, X|_])."
        , "second(b, [a, b, c, d])."
        , "second(2, [1, 2])."
        , "second([o, o], [x, [o, o], x, [x, x], [x, x, [x], x]])."
        ]).
    query("second(b, [a, b, c, d]).").

    markscheme(\inline_code("second(X, [_, X|_]).")).
:- end_object.


:- object('4.3.5', extends(predicate_quiz)).
    title("Swap12 Predicate"). % In what order do these unify).

    subcontent(
        [ p(["Write a predicate ", \inline_code("swap12(List1, List2)"), " which checks whether ", \inline_code("List1"), " is identical to ", \inline_code("List2"), ", except that the first two elements are exchanged."])
        ]).

    tests(
        [ "swap12([H1, H2|T], [H2, H1|T])."
        , "swap12([a, b, c], [b, a, c])."
        , "swap12([o, [o, o], x, [x, x], [x, x, [x], x]], [[o, o], o, x, [x, x], [x, x, [x], x]])."
        , "swap12([1, X, 2, 3], [X, 1, 2, 3])."
        ]
    ).
    query("swap12([a, b, 1, 2, 3], [b, a, 1, 2, 3]).").

    markscheme(\inline_code("swap12([H1, H2|T], [H2, H1|T]).")).
:- end_object.


:- object('4.3.6', extends(predicate_quiz_with_kb)).

    title("List Translation").

    subcontent(
        [ p("Suppose we are given a knowledge base with the following facts:")
        , \static_code_block(
            [ "tran(eins, one)."
            , "tran(zwei, two)."
            , "tran(drei, three)."
            , "tran(vier, four)."
            , "tran(fuenf, five)."
            , "tran(sechs, six)."
            , "tran(sieben, seven)."
            , "tran(acht, eight)."
            , "tran(neun, nine)."
            ])
        , p([ "Write a predicate ", \inline_code("listtran(G, E)"), " which translates a list of German number words to the corresponding list of English number words. For example:"])
        , \static_code_block("listtran([eins, neun, zwei], X).")
        , p("should give:")
        , \static_code_block("X = [one, nine, two].")
        , p("Your program should also work in the other direction. For example if you give it the query:")
        , \static_code_block("listtran(X, [one, seven, six, two]).")
        , p("it should return")
        , \static_code_block("X = [eins, sieben, sechs, zwei].")
        , p(
            [ '(Hint: to answer this question, first ask yourself "How do I translate the '
            , em("empty")
            , ' list of number words?".'
            , " That's the base case. For non-empty lists, first translate the head of the list, then use recursion to translate the tail.)"
            ])
        ]).

    tests(
        [ "listtran([eins, neun, zwei], [one, nine, two])."
        , "listtran(X, [one, seven, six, two]), X = [eins, sieben, sechs, zwei]."
        , "listtran([], [])."
        , "listtran([drei], [three])."
        ]).
    kb([ "tran(eins, one)."
       , "tran(zwei, two)."
       , "tran(drei, three)."
       , "tran(vier, four)."
       , "tran(fuenf, five)."
       , "tran(sechs, six)."
       , "tran(sieben, seven)."
       , "tran(acht, eight)."
       , "tran(neun, nine)."
       ]).
    query("listtran([eins, zwei, drei], [one, two, three]).").
    markscheme([ p("The base clause: the input list is empty. There is nothing to translate, so the output list is empty as well.")
               , \static_code_block("listtran([], []).")
               , p(["The recursive clause: we translate the head ", \inline_code("G"), " of the input list using the predicate ", \inline_code("tran/2"), ". The result is ", \inline_code("E"), " and becomes the head of the output list. Then we recursibely translate the rest of the input. The result becomes the rest of the output."])
               , \static_code_block(
                   [ "listtran([G|GT], [E|ET]) :-"
                   , "    tran(G, E),"
                   , "    listtran(GT, ET)."
                   ])
               ]).
:- end_object.


:- object('4.3.7', extends(predicate_quiz)).
    title("List Doubling").

    subcontent([ p(["Write a predicate ", \inline_code("twice(In, Out)"), " whose left argument is a list, and whose right argument is a list consisting of every element in the left list written twice. For example, the query"])
               , \static_code_block("twice([a, 4, buggle], X).")
               , p("should return")
               , \static_code_block("X = [a, a, 4, 4, buggle, buggle].")
               , p("And the query")
               , \static_code_block("twice([1, 2, 1, 1], X).")
               , p("should return")
               , \static_code_block("X = [1, 2, 2, 2, 1, 1, 1, 1].")
               , p(["(Hint: to answer this question, first ask yourself \"What should happen when the first argument is the ", em("empty"), " list?\" That's the base case. For the non-empty lists, think about what you should do with the head, and use recursion to handle the tail.)"])
               ]).
    tests([ "twice([a, 4, buggle], [a, a, 4, 4, buggle, buggle])."
          , "twice([1, 2, 1, 1], X), X = [1, 2, 2, 2, 1, 1, 1, 1]."
          , "twice([], [])."
          , "twice([X], [X, X])."
          , "twice([[o, o], [x, x]], [[o, o], [o, o], [x, x], [x, x]])."
          ]).
    query("twice([a, 4, buggle], [a, a, 4, 4, buggle, buggle]).").
    markscheme([ p("The base clause: the input list is empty. So there is nothing to write to the output list. So that is empty as well.")
               , \static_code_block("twice([], []).")
               , p("The recursive clause: the first two elements of the output list are both identical to the head of the input list. The recursive call simply produces the tail of the output list from the tail of the input list.")
               , \static_code_block(["twice([H|TIn], [H, H|TOut]) :-", "    twice(TIn, TOut)."])
               ]).
:- end_object.


:- object('4.3.8', extends(offline_markscheme_quiz)).
    title("Member Search Trees").
    subcontent(
        [ p(["Draw the search trees for the following queries:"])
        , \static_code_block("?- member(a, [c, b, a, y]).")
        , \static_code_block("?- member(x, [a, b, c]).")
        , \static_code_block("?- member(X, [a, b, c]).")
        , p(["(Search trees were introduced in ", a(href("/section/2.2"), "Chapter 2"), ".)"])
        ]).
    markscheme([]).
:- end_object.
