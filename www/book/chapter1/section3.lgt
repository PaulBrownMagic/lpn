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
    required_script('mcq.js').

    subcontent --> html_write::html(p("Which of the following sequences of characters are atoms, which are variables, and which are neither?")).
:- end_object.


