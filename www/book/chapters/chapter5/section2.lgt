:- object('5.2',
    extends(leaf_section)).
    title("A Closer Look").
    keyTerms([]).

    subcontent(
        [ p(["That’s the basics, but we need to know more. The most important to grasp is this: ", \inline_code("+"), ", ", \inline_code("*"), ", ", \inline_code("-"), ", ", \inline_code("÷"), " and ", \inline_code("mod"), " do ", em("not"), " carry out any arithmetic. In fact, expressions such as ", \inline_code("3+2"), ", ", \inline_code("3-2"), " and ", \inline_code("3*2"), " are simply terms. The functors of these terms are ", \inline_code("+"), ", ", \inline_code("-"), " and ", \inline_code("*"), " respectively, and the arguments are ", \inline_code("3"), " and ", \inline_code("2"), ". Apart from the fact that the functors go between their arguments (instead of in front of them) these are ordinary Prolog terms, and unless we do something special, Prolog will not actually do any arithmetic. In particular, if we pose the query"])
        , \code_query("X = 3+2.")
        , p(["we don’t get back the answer ", \inline_code("X=5"), ". Instead we get back"])
        , \static_code_block(["X = 3+2 ;", "yes."])
        , p(["That is, Prolog has simply unified the variable ", \inline_code("X"), " to the complex term ", \inline_code("3+2"), ". It has ", em("not"), " carried out any arithmetic. It has simply done what it usually does when ", \inline_code("=/2"), " is used: performed unification."])
        , p(["Similarly, if we pose the query"])
        , \code_query("3+2*5 = X.")
        , p(["we get the response"])
        , \static_code_block(["X = 3+2*5 ;", "yes."])
        , p(["Again, Prolog has simply bound the variable ", \inline_code("X"), " to the complex term ", \inline_code("3+2*5"), ". It did not evaluate this expression to ", \inline_code("13"), "."])
        , p(["To force Prolog to actually evaluate arithmetic expressions we have to use"])
        , \static_code_block(["is"])
        , p(["just as we did in our earlier examples. In fact, is does something very special: it sends a signal to Prolog that says “Hey! Don’t treat this expression as an ordinary complex term! Call up your built-in arithmetic capabilities and carry out the calculations!”"])
        , p(["In short, is forces Prolog to act in an unusual way. Normally Prolog is quite happy just unifying variables to structures: that’s its job, after all. Arithmetic is something extra that has been bolted on to the basic Prolog engine because it is useful. Unsurprisingly, there are some restrictions on this extra ability, and we need to know what they are."])
        , p(["For a start, the arithmetic expressions to be evaluated must be on the right hand side of is . In our earlier examples we carefully posed the query"])
        , \code_query("X is 6+2.")
        , p(["which is the right way to do it. If instead we had asked"])
        , \code_query("6+2 is X.")
        , p(["we would have got a message saying ", \inline_code("instantiation_error"), ", or something similar."])
        , p(["Moreover, although we are free to use variables on the right hand side of ", \inline_code("is"), ", when we actually carry out evaluation, the variable must already have been instantiated to a variable-free arithmetic expression. If the variable is uninstantiated, or if it is instantiated to something other than an integer, we will get some sort of ", \inline_code("instantiation_error"), " message. This is because arithmetic isn’t performed using Prolog’s usual unification and knowledge base search mechanisms: it’s done by calling up a special black box which knows about integer arithmetic. If we hand the black box the wrong kind of data, it’s going to complain."])
        , p(["Here’s an example. Recall our “add 3 and double it” predicate."])
        , \code_block("adddbl", ["add_3_and_double(X,Y) :- Y is (X+3)*2."])
        , p(["When we described this predicate, we carefully said that it added ", \inline_code("3"), " to its first argument, doubled the result, and returned the answer in its second argument. For example, ", \inline_code("add_3_and_double(3,X)"), " returns ", \inline_code("X = 12"), ". We didn’t say anything about using this predicate in the reverse direction. For example, we might hope that posing the query"])
        , \code_query("adddbl", "add_3_and_double(X, 12).")
        , p(["would return the answer ", \inline_code("X = 3"), ". But it doesn’t. Instead we get the ", \inline_code("instantiation_error"), " message. Why? Well, when we pose the query this way round, we are asking Prolog to evaluate ", \inline_code("12 is (X+3)*2"), ", which it ", em("can’t"), " do as ", \inline_code("X"), " is not instantiated."])
        , p(["Two final remarks. As we’ve already mentioned, for Prolog ", \inline_code("3 + 2"), " is just a term. In fact, for Prolog, it really ", em("is"), " the term ", \inline_code("+(3,2)"), ". The expression ", \inline_code("3 + 2"), "is just a user-friendly notation that’s nicer for us to use. This means that, if you want to, you can give Prolog queries like"])
        , \code_query("X is +(3,2).")
        , p(["and Prolog will correctly reply"])
        , \static_code_block(["X = 5 ;"])
        , p(["Actually, you can even give Prolog the query"])
        , \code_query("is(X,+(3,2)).")
        , p(["and Prolog will respond"])
        , \static_code_block(["X = 5 ;"])
        , p(["This is because, for Prolog, the expression ", \inline_code("X is +(3,2)"), " really is the term ", \inline_code("is(X,+(3,2))"), ". The expression ", \inline_code("X is +(3,2)"), " is just user-friendly notation. Underneath, as always, Prolog is just working away with terms."])
        , p(["Summing up, arithmetic in Prolog is easy to use. Pretty much all you have to remember is to use is to force evaluation, that stuff to be evaluated must go to the right of is , and to take care that any variables are correctly instantiated. But there is a deeper point that is worth reflecting on: bolting on the extra capability to do arithmetic in this way has further widened the gap between the procedural and declarative meanings of Prolog programs."])
        ]
    ).
:- end_object.
