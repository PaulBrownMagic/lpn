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

    subcontent --> html_write::html(p("Which of the following sequences of characters are atoms, which are variables, and which are neither?")).
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

    subcontent --> html_write::html(p("Which of the following sequences of characters are atoms, which are variables, which are complex terms, and which are not terms at all?")).
:- end_object.
