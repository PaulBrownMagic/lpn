:- object('5.3',
    extends(leaf_section)).
    title("Arithmetic and Lists").
    keyTerms(['accumulators', 'tail recursive']).

    subcontent(
        [ p(["Probably the most important use of arithmetic in this book is to tell us useful facts about data-structures, such as lists. For example, it can be useful to know how long a list is. We’ll give some examples of using lists together with arithmetic capabilities."])
        , p(["How long is a list? Here’s a recursive definition."])
        , ol([ li("The empty list has length zero.")
             , li(["A non-empty list has length ", \inline_code("1 + len(T)"), ", where ", \inline_code("len(T)"), " is the length of its tail."])
             ])
        , p(["This definition is practically a Prolog program already. Here’s the code we need:"])
        , \code_block("len",
          [ "len([], 0)."
          , "len([_|T], N) :-"
          , "    len(T, X),"
          , "    N is X+1."
          ])
        , p(["This predicate works in the expected way. For example:"])
        , \code_query("len", "len([a, b, c, d, e, [a, b], g], X).")
        , p(["Now, this is quite a good program: it’s easy to understand and efficient. But there is another method of finding the length of a list. We’ll now look at this alternative, because it introduces the idea of accumulators. If you’re used to other programming languages, you’re probably used to the idea of using variables to hold intermediate results. An accumulator is the Prolog analog of this idea."])
        , p(["Here’s how to use an accumulator to calculate the length of a list. We shall define a predicate ", \inline_code("accLen/3"), " which takes the following arguments."])
        , \static_code_block([ "accLen(List,Acc,Length)" ])
        , p(["Here ", \inline_code("List"), " is the list whose length we want to find, and ", \inline_code("Length"), " is its length (an integer). What about ", \inline_code("Acc"), "? This is the accumulator we will use to keep track of intermediate values for length (so it will also be an integer). Here’s what we do. When we call this predicate, we are going to give ", \inline_code("Acc"), " an initial value of ", \inline_code("0"), ". We then recursively work our way down the list, adding ", \inline_code("1"), " to ", \inline_code("Acc"), " each time we find a head element, until we reach the empty list. When we reach the empty list, ", \inline_code("Acc"), " will contain the length of the list. Here’s the code:"])
        , \code_block("acclen",
            [ "accLen([_|T], A, L) :-"
            , "    Anew is A+1,"
            , "    accLen(T, Anew, L)."
            , "accLen([], A, A)."
            ])
        , \code_query("acclen", "accLen([a, b, c, d, e, [a, b], g], 0, X).")
        , p(["The base case of the definition, unifies the second and third arguments. Why? Because this trivial unification is a nice way of making sure that the result, that is, the length of the list, is returned. When we reach the end of the list, the accumulator (the second variable) contains the length of the list. So we give this value (via unification) to the length variable (the third variable). Here’s an example trace. You can clearly see how the length variable gets its value at the bottom of the recursion and passes it upwards as Prolog is coming out of the recursion."])
        , \static_code_block(
            [ "?- accLen([a, b, c], 0, L)."
            , "Call: (6) accLen([a, b, c], 0, _G449) ?"
            , "Call: (7) _G518 is 0+1 ?"
            , "Exit: (7) 1 is 0+1 ?"
            , "Call: (7) accLen([b, c], 1, _G449) ?"
            , "Call: (8) _G521 is 1+1 ?"
            , "Exit: (8) 2 is 1+1 ?"
            , "Call: (8) accLen([c], 2, _G449) ?"
            , "Call: (9) _G524 is 2+1 ?"
            , "Exit: (9) 3 is 2+1 ?"
            , "Call: (9) accLen([], 3, _G449) ?"
            , "Exit: (9) accLen([], 3, 3) ?"
            , "Exit: (8) accLen([c], 2, 3) ?"
            , "Exit: (7) accLen([b, c], 1, 3) ?"
            , "Exit: (6) accLen([a, b, c], 0, 3) ?"
            ])
        , p(["As a final step, we’ll define a predicate which calls accLen for us, and gives it the initial value of ", \inline_code("0"), ":"])
        , \static_code_block([" leng(List, Length) :- accLen(List, 0, Length)." ])
        , p(["So now we can pose queries like this:"])
        , \static_code_block([ "?- leng([a, b, c, d, e, [a, b], g], X)." ])
        , p(["Accumulators are extremely common in Prolog programs. (We’ll see another accumulator based program in this chapter, and some more in later chapters.) But why is this? In what way is ", \inline_code("accLen"), " better than ", \inline_code("len"), "? After all, it looks more difficult. The answer is that ", \inline_code("accLen"), " is tail recursive while ", \inline_code("len"), " is not. In tail recursive programs, the result is fully calculated once we reached the bottom of the recursion and just has to be passed up. In recursive programs which are not tail recursive, there are goals at other levels of recursion which have to wait for the answer from a lower level of recursion before they can be evaluated. To understand this, compare the traces for the queries ", \inline_code("accLen([a, b, c], 0, L)"), " (see above) and ", \inline_code("len([a, b, c], 0, L)"), " (given below). In the first case the result is built while going into the recursion — once the bottom is reached at ", \inline_code("accLen([], 3, _G449)"), ", the result is there and only has to be passed up. In the second case the result is built while coming out of the recursion; the result of ", \inline_code("len([b,c], _G481)"), ", for instance, is only computed after the recursive call of ", \inline_code("len"), " has been completed and the result of ", \inline_code("len([c], _G489)"), " is known. In short, tail recursive programs have less bookkeeping overhead, and this makes them more efficient."])
        , \static_code_block(
            [ "?-  len([a, b, c], L)."
            , "Call: (6) len([a, b, c], _G418) ?"
            , "Call: (7) len([b, c], _G481) ?"
            , "Call: (8) len([c], _G486) ?"
            , "Call: (9) len([], _G489) ?"
            , "Exit: (9) len([], 0) ?"
            , "Call: (9) _G486 is 0+1 ?"
            , "Exit: (9) 1 is 0+1 ?"
            , "Exit: (8) len([c], 1) ?"
            , "Call: (8) _G481 is 1+1 ?"
            , "Exit: (8) 2 is 1+1 ?"
            , "Exit: (7) len([b, c], 2) ?"
            , "Call: (7) _G418 is 2+1 ?"
            , "Exit: (7) 3 is 2+1 ?"
            , "Exit: (6) len([a, b, c], 3) ?"
            ])
        ]
    ).
:- end_object.
