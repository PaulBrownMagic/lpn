:- object('1.3',
    extends(exercises)).
    children(['1.3.1', '1.3.2', '1.3.3', '1.3.4', '1.3.5', '1.3.6', '1.3.7', '1.3.8']).
:- end_object.


:- object('1.3.1',
    extends(mcq)).
    title("Atoms and Variables").
    question_options([atom, variable, neither]).
    questions([ question('vINCENT', atom, 'atoms begin with a lowercase letter')
              , question('Footmassage', variable, 'variables begin with an uppercase letter')
              , question('variable23', atom, 'atoms begin with a lowercase letter')
              , question('Variable2000', variable, 'variables begin with an uppercase letter')
              , question('big_kahuna_burger', atom, 'atoms begin with a lowercase letter')
              , question('\'big_kahuna_burger\'', atom, 'atoms can be surrounded by single quotes')
              , question('big kahuna burger', neither, 'neither atoms nor variables can contain spaces, unless they start and end with a single quote')
              , question('\'Jules\'', atom, 'atoms can be surrounded by single quotes')
              , question('_Jules', variable, 'variables can begin with an underscore \'_\'')
              , question('\'_Jules\'', atom, 'atoms can be surrounded by single quotes')
              ]).

    subcontent(p("Which of the following sequences of characters are atoms, which are variables, and which are neither?")).
:- end_object.


:- object('1.3.2',
    extends(mcq)).

    title("Atoms, Variables, and Complex Terms").
    question_options([atom, variable, 'complex term', neither]).
    questions([ question('loves(Vincent, mia)', 'complex term', 'complex terms have a functor and an arity')
              , question('\'loves(Vincent, mia)\'', atom, 'atoms can be surrounded by single quotes')
              , question('Butch(boxer)', neither, 'a functor cannot begin with an uppercase letter')
              , question('butch(Boxer)', 'complex term', 'complex terms have a functor and an arity')
              , question('and(big(burger), kahuna(burger))', 'complex term', 'complex terms can contain other complex terms')
              , question('and(big(X), kahuna(X))', 'complex term', 'complex terms can contain other complex terms')
              , question('_and(big(X), kahuna(X))', neither, 'functors, like atoms, cannot be prefixed with the underscore')
              , question('(Butch kills Vincent)', neither, 'spaces in parenthesis is invalid syntax')
              , question('kills(Butch Vincent)', neither, 'arguments in a complex term must be comma seperated')
              , question('kills(Butch, Vincent', neither, 'an opening parenthesis must be closed after the arguments')
              ]).

    subcontent(p("Which of the following sequences of characters are atoms, which are variables, which are complex terms, and which are not terms at all?")).
:- end_object.


:- object('1.3.3',
    extends(input_compare_quiz)).
    title("Functor and Arity").
    questions([ question('loves(Vincent, mia)', 'loves/2', 'the functor is \'loves\', the arity is \'2\', so the answer is \'loves/2\'.')
              , question('butch(Boxer)', 'butch/1', 'the functor precedes the brackets, the arity is the count of arguments')
              , question('and(big(burger), kahuna(burger))', 'and/2', 'whether arguments are complex terms or not, they still count as 1 each')
              , question('and(big(X), kahuna(X))', 'and/2', 'whether arguments are complex terms or not, they still count as 1 each')
              , question('kills(Butch, Vincent)', 'kills/2', 'the functor precedes the brackets, the arity is the count of arguments')
              ]).

    subcontent(
        [ p("What is the functor and arity of each of these complex terms?")
        , p([em("Remember: functor and arity is written as "), \inline_code("functor/arity")])
        ]).
:- end_object.


:- object('1.3.4',
    extends(input_compare_quiz)).

    title("Facts, rules, clauses and predicates").
    questions([ question('How many facts are there?', '3', 'a fact is unconditionally true, so it does not contain ":-" in its definition')
              , question('How many rules are there?', '4', 'a rule is conditionally true, so it contains ":-" in its definition')
              , question('How many clauses are there?', '7', 'all facts and rules are clauses')
              , question('How many predicates are defined?', '5', 'a defined predicate is a fact or the head of a rule, we have defined: woman/1, man/1, person/1, loves/2, and father/2')
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


:- object('1.3.5',
    extends(mcq)).

    title("Heads, Bodies and Goals").
    question_options([head, goal, body, neither]).
    questions([ question('woman(vincent)', neither, 'a fact does not have a head or body')
              , question('woman(X)', goal, 'a goal part of the body of a rule')
              , question('man(jules)', neither, 'a fact does not have a head or body')
              , question('man(X)', goal, 'a goal part of the body of a rule')
              , question('person(X)', head, 'the head precedes ":-" in a rule')
              , question('loves(X, Y)', head, 'the head precedes ":-" in a rule')
              , question('man(X) ; woman(X)', body, 'the body is everything following the ":-" in a rule')
              , question('man(Y), son(Z, Y)', body, 'the body is everything following the ":-" in a rule')
              , question('knows(X, Y)', neither, 'knows(X, Y) is not part of the knowledge base')
              ]).
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


:- object('1.3.6',
    extends(leaf_section)).

    title("Representing Facts and Rules").
    questions([ question('Butch is a killer.', 'killer(butch).')
              , question('Mia and Marcellus are married.', 'married(mia, marcellus).')
              , question('Zed is dead.', 'dead(zed).')
              , question('Marcellus kills everyone who gives Mia a footmassage.', 'kill(marcellus, X) :- give(X, mia, Y), footmassage(Y).')
              , question('Mia loves everyone who is a good dancer.', 'love(mia, X) :- good_dancer(X).')
              , question('Jules eats anything that is nutritious or tasty', 'eat(jules, X) :- nutritious(X) ; tasty(X).')
              ]).
    subcontent(
        [ p("Represent the following in Prolog:")
        , div(class(row),
            [ \input_mark_quiz('1.3.6')
            , div([id(markscheme), class(['col'])],
                [ input([type(button), class([btn, 'btn-primary']), value('Check Answers'), onclick('markscheme()')], [])
                , p(class([collapse, markscheme]), ["Here is an example of what your answers could look like.  They, of course, don't have to look ", em("exactly"), " like that. For example, the first fact could also be ", \inline_code("killer('Butch')"), " or ", \inline_code("killer(b)"), " or even ", \inline_code("k(50)"), ", if you decide to represent Butch by the number 50 and the property of being a killer by the predicate ", \inline_code("k/1"), "."])
                ])
            ])
        ]).
:- end_object.


:- object('1.3.7',
    extends(mcq)).

    title("Answering Queries").
    question_options([yes, no, 'ERROR']).
    questions([ question('wizard(ron).', yes, 'queries unify with facts')
              , question('witch(ron).', 'ERROR', 'witch/1 is undefined')
              , question('wizard(hermione).', no, 'hermione is not in the knowledge base')
              , question('witch(hermione)', 'ERROR', 'witch/1 is undefined')
              , question('wizard(harry)', yes, 'the goal clauses of the rule wizard/1 succeed for harry')
              ]).
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


:- object('1.3.8',
    extends(mcq)).

    title("Unifying Queries").
    question_options([yes, no]).
    questions([ question('Y = ron', yes, 'Y unifies with ron in the fact wizard(ron)')
              , question('Y = hermione', no, 'hermione is not in the knowledge base')
              , question('Y = harry', yes, 'Y unifies with harry via the rule wizard/1')
              , question('no', yes, 'once all possible unifications are exhausted, Prolog will return no')
              ]).
    subcontent(
        [ p("Suppose we are working with the following knowledge base:")
        , \static_code_block(
'wizard(ron).
hasWand(harry).
quidditchPlayer(harry).
wizard(X) :- hasBroom(X), hasWand(X).
hasBroom(X) :- quidditchPlayer(X).
')
        , p(["Does Prolog give the following response to the query ", \inline_code("?- wizard(Y)."), " ?"])
        ]).
:- end_object.
