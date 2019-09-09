:- object('4.2',
    extends(leaf_section)).
    title("Member").
    keyTerms(['member']).

    subcontent(
        [ p(["It’s time to look at our first example of a recursive Prolog program for manipulating lists. One of the most basic things we would like to know is whether something is an element of a list or not. So let’s write a program that, when given as inputs an arbitrary object ", \inline_code("X"), " and a list ", \inline_code("L"), ", tells us whether or not ", \inline_code("X"), " belongs to ", \inline_code("L"), ". The program that does this is usually called member , and it is the simplest example of a Prolog program that exploits the recursive structure of lists. Here it is:"])
        , \code_block("member",
            [ "member(X,[X|T])."
            , "member(X,[H|T])  :-  member(X,T)."
            ])
        , p(["That’s all there is to it: one fact (namely ", \inline_code("member(X,[X|T])"), ") and one rule (namely ", \inline_code("member(X,[H|T]) :- member(X,T)"), " ). But note that the rule is recursive (after all, the functor member occurs in both the rule’s head and body) and it is this that explains why such a short program is all that is required. Let’s take a closer look."])
        , p(["We’ll start by reading the program declaratively. And read this way, it is obviously sensible. The first clause (the fact) simply says: an object ", \inline_code("X"), " is a member of a list if it is the head of that list. Note that we used the built-in ", \inline_code("|"), " operator to state this (simple but important) principle about lists."])
        , p(["What about the second clause, the recursive rule? This says: an object ", \inline_code("X"), " is member of a list if it is a member of the tail of the list. Again, note that we used the ", \inline_code("|"), " operator to state this principle."])
        , p(["Now, clearly this definition makes good declarative sense. But does this program actually ", em("do"), " what it is supposed to do? That is, will it really tell us whether an object ", \inline_code("X"), " belongs to a list ", \inline_code("L"), "? And if so, how exactly does it do this? To answer such questions, we need to think about its procedural meaning. Let’s work our way through a few examples."])
        , p(["Suppose we posed the following query:"])
        , \code_query("member", "member(yolanda,[yolanda,trudy,vincent,jules]).")
        , p(["Prolog will immediately answer yes. Why? Because it can unify ", \inline_code("yolanda"), " with both occurrences of ", \inline_code("X"), " in the first clause (the fact) in the definition of ", \inline_code("member/2"), ", so it succeeds immediately."])
        , p(["Next consider the following query:"])
        , \code_query("member", "member(vincent,[yolanda,trudy,vincent,jules]).")
        , p(["Now the first rule won’t help (", \inline_code("vincent"), " and ", \inline_code("yolanda"), " are distinct atoms) so Prolog goes to the second clause, the recursive rule. This gives Prolog a new goal: it now has to see if"])
        , \static_code_block("member(vincent,[trudy,vincent,jules]).")
        , p(["Once again the first clause won’t help, so Prolog goes (again) to the recursive rule. This gives it a new goal, namely"])
        , \static_code_block("member(vincent,[vincent,jules]).")
        , p(["This time, the first clause does help, and the query succeeds."])
        , p(["So far so good, but we need to ask an important question. What happens when we pose a query that ", em("fails"), "? For example, what happens if we pose the query"])
        , \code_query("member", "member(zed,[yolanda,trudy,vincent,jules]).")
        , p(["Now, this should obviously fail (after all, zed is not on the list). So how does Prolog handle this? In particular, how can we be sure that Prolog really will ", em("stop"), ", and say ", em("no"), ", instead going into an endless recursive loop?"])
        , p(["Let’s think this through systematically. Once again, the first clause cannot help, so Prolog uses the recursive rule, which gives it a new goal"])
        , \static_code_block("member(zed,[trudy,vincent,jules]).")
        , p(["Again, the first clause doesn’t help, so Prolog reuses the recursive rule and tries to show that"])
        , \static_code_block("member(zed,[vincent,jules]).")
        , p(["Similarly, the first rule doesn’t help, so Prolog reuses the second rule yet again and tries the goal"])
        , \static_code_block("member(zed,[jules]).")
        , p(["Again the first clause doesn’t help, so Prolog uses the second rule, which gives it the goal"])
        , \static_code_block("member(zed,[])")
        , p(["And ", em("this"), " is where things get interesting. Obviously the first clause can’t help here. But note: ", em("the recursive rule can’t do anything more either"), ". Why not? Simple: the recursive rule relies on splitting the list into a head and a tail, but as we have already seen, the empty list ", em("can’t"), " be split up in this way. So the recursive rule cannot be applied either, and Prolog stops searching for more solutions and announces no. That is, it tells us that ", \inline_code("zed"), " does not belong to the list, which is just what it ought to do."])
        , p(["We could summarise the ", \inline_code("member/2"), " predicate as follows. It is a recursive predicate, which systematically searches down the length of the list for the required item. It does this by stepwise breaking down the list into smaller lists, and looking at the first item of each smaller list. This mechanism that drives this search is recursion, and the reason that this recursion is safe (that is, the reason it does not go on forever) is that at the end of the line Prolog has to ask a question about the empty list. The empty list ", em("cannot"), " be broken down into smaller parts, and this allows a way out of the recursion."])
        , p(["Well, we’ve now seen why ", \inline_code("member/2"), " works, but in fact it’s far more useful than the previous example might suggest. Up till now we’ve only been using it to answer yes/no questions. But we can also pose questions containing variables. For example, we can have the following dialog with Prolog:"])
        , \code_query("member", "member(X,[yolanda,trudy,vincent,jules]).")
        , p(["That is, Prolog has told us what every member of a list is. This is an extremely common use of ", \inline_code("member/2"), ". In effect, by using the variable we are saying to Prolog: “Quick! Give me some element of the list!”. In many applications we need to be able to extract members of a list, and this is the way it is typically done."])
        , p(["One final remark. The way we defined ", \inline_code("member/2"), " above is certainly correct, but in one respect it is a little messy."])
        , p(["Think about it. The first clause is there to deal with the head of the list. But although the tail is irrelevant to the first clause, we named the tail using the variable ", \inline_code("T"), ". Similarly, the recursive rule is there to deal with the tail of the list. But although the head is irrelevant here, we named it using the variable ", \inline_code("H"), ". These unnecessary variable names are distracting: it’s better to write predicates in a way that focuses attention on what is really important in each clause, and the anonymous variable gives us a nice way of doing this. That is, we can rewrite ", \inline_code("member/2"), " as follows:"])
        , \static_code_block(
            [ "member(X,[X|_])."
            , "member(X,[_|T])  :-  member(X,T)."
            ])
        , p(["This version is exactly the same, both declaratively and procedurally. But it’s just that little bit clearer: when you read it, you are forced to concentrate on what is essential. "])
        ]
    ).
:- end_object.
