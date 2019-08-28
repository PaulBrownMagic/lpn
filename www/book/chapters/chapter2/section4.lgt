:- object('2.4',
    extends(practice)).
    keyTerms(['trace mode']).

    subcontent(
        [ p(["By this stage, you should have had your first taste of running Prolog programs. The purpose of the second practical session is to suggest two sets of keyboard exercises which will help you get familiar with the way Prolog works. The first set has to do with unification, the second with proof search."])
        , p(["First of all, start up your Prolog interpreter. That is, get a screen displaying the usual “I’m ready to start” prompt, which probably looks something like:"])
        , \static_code_block("?-")
        , p(["Verify your answers to Exercise 2.1, the unification examples. You don’t need to consult any knowledge bases, simply ask Prolog directly whether it is possible to unify the terms by using the built-in ", \inline_code("=/2"), " predicate. For example, to test whether ", \inline_code("food(bread,X)"), " and ", \inline_code("food(Y,sausage)"), " unify, just type in"])
        , \static_code_block("food(bread,X)  =  food(Y,sausage).")
        , p(["and hit return."])
        , p(["You should also look at what happens when your Prolog implementation attempts to unify terms that can’t be unified because it doesn’t carry out an occurs check. For example, see what happens when you give it the following query:"])
        , \code_query("g(X,Y)  =  Y.")
        , p(["If it handles such examples, try the trickier one mentioned in the text:"])
        , \code_query("X =  f(X),  Y  =  f(Y),  X  =  Y.")
        , p(["Once you’ve experimented with that, it’s time to move on to something new. There is another built-in Prolog predicate for answering queries about unification, namely ", \inline_code("\\=/2"), " (that is: the 2-place predicate ", \inline_code("\\="), " ). This works in the opposite way to the ", \inline_code("=/2"), " predicate: it succeeds when its two arguments do ", em("not"), " unify. For example, the terms ", \inline_code("a"), " and ", \inline_code("b"), " do not unify, which explains the following dialogue:"])
        , \code_query("a  \\=  b.")
        , \static_code_block("yes")
        , p(["Make sure you understand how ", \inline_code("\\=/2"), " works by trying it out on (at least) the following examples. But do this actively, not passively. That is, after you type in an example, pause, and try to work out for yourself what Prolog is going to respond. Only then hit return to see if you are right."])
        , ol([ li(\code_query("a \\= a."))
             , li(\code_query("'a' \\= a."))
             , li(\code_query("A \\= a."))
             , li(\code_query("f(a) \\= a."))
             , li(\code_query("f(a) \\= A."))
             , li(\code_query("f(A) \\= f(a)."))
             , li(\code_query("g(a,B,c) \\= g(A,b,C)."))
             , li(\code_query("g(a,b,c) \\= g(A,C)."))
             , li(\code_query("f(X) \\= X."))
             ]
          )
        , p(["Thus the ", \inline_code("\\=/2"), " predicate is (essentially) the negation of the ", \inline_code("=/2"), " predicate: a query involving one of these predicates will be satisfied when the corresponding query involving the other is not, and vice versa. This is the first example we have seen of a Prolog mechanism for handling negation. We discuss Prolog negation (and its peculiarities) in ", a(href("/section/10"), "Chapter 10"), "."])
        , p(["It’s time to move on and introduce one of the most helpful tools in Prolog: ", \inline_code("trace"), ". This is a built-in Prolog predicate that changes the way Prolog runs: it forces Prolog to evaluate queries one step at a time, indicating what it is doing at each step. Prolog waits for you to press return before it moves to the next step, so that you can see exactly what is going on. It was really designed to be used as a debugging tool, but it’s also helpful when you’re learning Prolog: stepping through programs using ", \inline_code("trace"), " is an ", em("excellent"), " way of learning how Prolog proof search works."])
        , p(["Let’s look at an example. In the text, we looked at the proof search involved when we made the query ", \inline_code("k(Y)"), " to the following knowledge base:"])
        , \static_code_block(
            [ "f(a)."
            , "f(b)."
            , ""
            , "g(a)."
            , "g(b)."
            , ""
            , "h(b)."
            , ""
            , "k(X):-  f(X),  g(X),  h(X)."
            ]
          )
        , p(["Suppose this knowledge base is in file proof.pl . We first consult it:"])
        , \static_code_block(["?-  [proof].", "yes"])
        , p(["We then type trace , followed by a full stop, and hit return:"])
        , \static_code_block(["?-  trace.", "yes"])
        , p(["Prolog is now in trace mode, and will evaluate all queries step by step. For example, if we pose the query ", \inline_code("k(X)"), ", and then hit return every time Prolog comes back with a ", \inline_code("?"), ", we obtain (something like) the following:"])
        , \static_code_block(
            [ "[trace]  2  ?-  k(X)."
            , "    Call:  (6)  k(_G34)  ?"
            , "    Call:  (7)  f(_G34)  ?"
            , "    Exit:  (7)  f(a)  ?"
            , "    Call:  (7)  g(a)  ?"
            , "    Exit:  (7)  g(a)  ?"
            , "    Call:  (7)  h(a)  ?"
            , "    Fail:  (7)  h(a)  ?"
            , "    Fail:  (7)  g(a)  ?"
            , "    Redo:  (7)  f(_G34)  ?"
            , "    Exit:  (7)  f(b)  ?"
            , "    Call:  (7)  g(b)  ?"
            , "    Exit:  (7)  g(b)  ?"
            , "    Call:  (7)  h(b)  ?"
            , "    Exit:  (7)  h(b)  ?"
            , "    Exit:  (6)  k(b)  ?"
            , ""
            , "X  =  b"
            , "yes"
            ]
          )
        , p(["Study this carefully. That is, try doing the same thing yourself, and relate this output to the discussion of the example in the text, and in particular, to the nodes in the search tree. To get you started, we’ll remark that the third line is where the variable in the query is (wrongly) instantiated to ", \inline_code("a"), ". The first line marked ", \inline_code("fail"), " is where Prolog realises it’s taken the wrong path and starts to backtrack, and the line marked ", \inline_code("redo"), " is where it tries alternatives for the goal ", \inline_code("f(_G34)"), "."])
        , p(["While learning Prolog, use trace, and use it heavily. It’s a great way to learn. Oh yes: you also need to know how to turn trace off. Simply type ", \inline_code("notrace"), " (followed by a full stop) and hit return:"])
        , \static_code_block(
            [ "?-  notrace."
            , "yes"
            ]
          )
        ]
    ).
:- end_object.
