:- object('2.2',
    extends(leaf_section)).
    title("Proof Search").
    keyTerms(['proof search', 'choice points', 'backtracking', 're-satisfy', 'search tree']).

    subcontent(
        [ p(["Now that we’ve got some idea of what Prolog does, it’s time to go back to the beginning and work through the details more carefully. Let’s start by asking a very basic question: we’ve seen all kinds of expressions (for example ", \inline_code("jody"), ", ", \inline_code("playsAirGuitar(mia)"), ", and ", \inline_code("X"), ") in our Prolog programs, but these have just been examples. It’s time for precision: exactly what are facts, rules, and queries built out of?"])
        , p("The answer is terms, and there are four kinds of term in Prolog: atoms, numbers, variables, and complex terms (or structures). Atoms and numbers are lumped together under the heading constants, and constants and variables together make up the simple terms of Prolog.")
        , p(["Let’s take a closer look. To make things crystal clear, let’s first be precise about the basic characters (that is, symbols) at our disposal. The ", em("upper-case letters"), " are ", \inline_code("A, B ,…, Z;"), " the ", em("lower-case letters"), " are ", \inline_code("a, b ,…, z;"), " the ", em("digits"), " are ", \inline_code("0, 1 , 2 ,…, 9"), ". In addition we have the ", \inline_code("_"), " symbol, which is called underscore, and some ", em("special characters"), " , which include characters such as ", \inline_code("+, - , * , / , < , > , = , : , . , & , ~"), ". The blank ", em("space"), " is also a character, but a rather unusual one, being invisible. A string is an unbroken sequence of characters."])
        ]
    ).
:- end_object.
