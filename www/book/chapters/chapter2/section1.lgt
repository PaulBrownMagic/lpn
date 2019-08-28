:- object('2.1',
    extends(node_section)).

    title("Unification").
    children(['2.1.1', '2.1.2', '2.1.3']).
    keyTerms(['unification', 'instantiating', 'instantiations', 'recursively structured', 'share values']).

    subcontent(
        [ p(["When working with knowledge base KB4 in the previous chapter, we briefly mentioned the idea of unification. We said, for example, that Prolog unifies ", \inline_code("woman(X)"), " with ", \inline_code("woman(mia)"), ", thereby instantiating the variable ", \inline_code("X"), " to ", \inline_code("mia"), " . It’s now time to take a closer look at unification, for it is one of the most fundamental ideas in Prolog."])
        , p(["Recall that there are three types of term:"])
        , ul(class('list-group'),
            [ li(class('list-group-item'), ["Constants. These can either be atoms (such as ", \inline_code("vincent"), " ) or numbers (such as ", \inline_code("24"), ")."])
            , li(class('list-group-item'), ["Variables. (Such as ", \inline_code("X"), " , ", \inline_code("Z3"), " , and ", \inline_code("List"), ".)"])
            , li(class('list-group-item'), ["Complex terms. These have the form: ", \inline_code("functor(term_1,...,term_n)"), "."])
            ]
          )
        , p(["We are going to work our way towards a definition of when Prolog will unify two terms. Our starting point will be the following working definition. It gives the basic intuition, but is a little light on detail:"])
        , blockquote(class(blockquote), "Two terms unify if they are the same term or if they contain variables that can be uniformly instantiated with terms in such a way that the resulting terms are equal.")
        , p(["This means, for example, that the terms ", \inline_code("mia"), " and ", \inline_code("mia"), " unify, because they are the same atom. Similarly, the terms ", \inline_code("42"), " and ", \inline_code("42"), " unify, because they are the same number, the terms X and X unify, because they are the same variable, and the terms ", \inline_code("woman(mia)"), " and ", \inline_code("woman(mia)"), " unify, because they are the same complex term. The terms ", \inline_code("woman(mia)"), " and ", \inline_code("woman(vincent)"), " , however, do not unify, as they are not the same (and neither of them contains a variable that could be instantiated to make them the same)."])
        , p(["Now, what about the terms ", \inline_code("mia"), " and ", \inline_code("X"), "? They are not the same. However, the variable ", \inline_code("X"), " can be instantiated to ", \inline_code("mia"), " which makes them equal. So, by the second part of our working definition, ", \inline_code("mia"), " and ", \inline_code("X"), " unify. Similarly, the terms ", \inline_code("woman(X)"), " and ", \inline_code("woman(mia)"), " unify, because they can be made equal by instantiating ", \inline_code("X"), " to ", \inline_code("mia"), " . How about ", \inline_code("loves(vincent,X)"), " and ", \inline_code("loves(X,mia)"), "? No. It is impossible to find an instantiation of ", \inline_code("X"), " that makes the two terms equal. Do you see why? Instantiating ", \inline_code("X"), " to ", \inline_code("vincent"), " would give us the terms ", \inline_code("loves(vincent,vincent)"), " and ", \inline_code("loves(vincent,mia)"), ", which are obviously not equal. However, instantiating ", \inline_code("X"), " to ", \inline_code("mia,"), " would yield the terms ", \inline_code("loves(vincent,mia)"), " and ", \inline_code("loves(mia,mia)"), " , which aren’t equal either."])
        , p(["Usually we are not only interested in the fact that two terms unify, we also want to know how the variables have to be instantiated to make them equal. And Prolog gives us this information. When Prolog unifies two terms it performs all the necessary instantiations, so that the terms really are equal afterwards. This functionality, together with the fact that we are allowed to build complex terms (that is, recursively structured terms) makes unification a powerful programming mechanism."])
        , p(["The basic intuitions should now be clear. Here’s the definition which makes them precise. It tells us not only which terms Prolog will unify, but also what it will do to the variables to achieve this."])
        , ol(
            [ li([em("If "), \inline_code("term1"), em(" and "), \inline_code("term2"), em(" are constants, then "), \inline_code("term1"), em(" and "), \inline_code("term2"), em(" unify if and only if they are the same atom, or the same number.")])
            , li([em("If "), \inline_code("term1"), em(" is a variable and "), \inline_code("term2"), em(" is any type of term, then "), \inline_code("term1"), em(" and "), \inline_code("term2"), em(" unify, and "), \inline_code("term1"), em(" is instantiated to "), \inline_code("term2"), em(". Similarly, if "), \inline_code("term2"), em(" is a variable and "), \inline_code("term1"), em(" is any type of term, then "), \inline_code("term1"), em(" and "), \inline_code("term2"), em(" unify, and "), \inline_code("term2"), em(" is instantiated to "), \inline_code("term1"), em(". (So if they are both variables, they’re both instantiated to each other, and we say that they share values.)")])
            , li([em("If "), \inline_code("term1"), em(" and "), \inline_code("term2"), em(" are complex terms, then they unify if and only if:"),
                ol(type(a),
                    [ li(em("They have the same functor and arity, and"))
                    , li(em("all their corresponding arguments unify, and"))
                    , li([em("the variable instantiations are compatible. (For example, it is not possible to instantiate variable "), \inline_code("X"), em(" to "), \inline_code("mia"), em(" when unifying one pair of arguments, and to instantiate "), \inline_code("X"), em(" to "), \inline_code("vincent"), em(" when unifying another pair of arguments .)")])
                    ]
                )])
            , li(em("Two terms unify if and only if it follows from the previous three clauses that they unify."))
            ]
          )
        , p(["Let’s have a look at the form of this definition. The first clause tells us when two constants unify. The second clause tells us when two terms, one of which is a variable, unify (such terms will always unify; variables unify with ", em("anything"), "). Just as importantly, this clause also tells what instantiations we have to perform to make the two terms the same. Finally, the third clause tells us when two complex terms unify. Note the structure of this definition. Its first three clauses mirror perfectly the (recursive) structure of terms."])
        , p(["The fourth clause is also important: it says that the first three clauses tell us all we need to know about the unification of two terms. If two terms can’t be shown to unify using clauses 1–3, then they ", em("don’t"), " unify. For example, ", \inline_code("batman"), " does not unify with ", \inline_code("daughter(ink)"), ". Why not? Well, the first term is a constant, and the second is a complex term. But none of the first three clauses tell us how to unify two such terms, hence (by clause 4) they don’t unify."])
        ]
    ).
:- end_object.


:- object('2.1.1',
    extends(leaf_section)).

    title("Examples").
    keyTerms(['infix']).

    subcontent(
        [ p(["To make sure we’ve fully understood this definition, let’s work through several examples. In these examples we’ll make use of an important built-in predicate, the ", \inline_code("=/2"), " predicate (recall that writing ", \inline_code("/2"), " at the end indicates that this predicate takes two arguments)."])
        , p(["The ", \inline_code("=/2"), " predicate tests whether its two arguments unify. For example, if we pose the query"])
        , \code_query("=(mia,mia).")
        , p(["Prolog will respond ", \inline_code("yes"), ", and if we pose the query"])
        , \code_query("=(mia,vincent).")
        , p(["Prolog will respond ", \inline_code("no"), "."])
        , p(["But we usually wouldn’t pose these queries in quite this way. Let’s face it, the notation ", \inline_code("=(mia,mia)"), " is rather unnatural. It would be nicer if we could use infix notation (that is, if we could put the ", \inline_code("=/2"), " functor between its arguments) and write things like:"])
        , \static_code_block("?-  mia  =  mia.")
        , p(["In fact, Prolog lets us do this, so in the examples that follow we’ll use infix notation."])
        , p(["Let’s return to our first example:"])
        , \code_query("mia  =  mia.")
        , \static_code_block("yes.")
        , p(["Why does Prolog say ", \inline_code("yes"), "? This may seem like a silly question: surely it’s obvious that the terms unify! That’s true, but how does this follow from the definition given above? It is important to learn to think systematically about unification (it is utterly fundamental to Prolog), and thinking systematically means relating the examples to the definition of unification given above. So let’s think this example through."])
        , p(["The definition has three clauses. Now, clause 2 is for when one argument is a variable, and clause 3 is for when both arguments are complex terms, so these are of no use here. However clause 1 ", em("is"), " relevant to our example. This tells us that two constants unify if and only if they are exactly the same object. As ", \inline_code("mia"), " and ", \inline_code("mia"), " are the same atom, unification succeeds."])
        , p(["A similar argument explains the following responses:"])
        , \code_query("2  =  2.")
        , \static_code_block("yes.")
        , \code_query("mia  =  vincent.")
        , \static_code_block("no.")
        , p(["Once again, clause 1 is relevant here (after all, ", \inline_code("2"), ", ", \inline_code("mia"), ", and ", \inline_code("vincent"), " are all constants). And as ", \inline_code("2"), " is the same number as ", \inline_code("2"), ", and as ", \inline_code("mia"), " is not the same atom as ", \inline_code("vincent"), ", Prolog responds ", \inline_code("yes"), " to the first query and ", \inline_code("no"), " to the second."])
        , p(["However clause 1 does hold one small surprise for us. Consider the following query:"])
        , \code_query("'mia'  =  mia.")
        , \static_code_block("yes.")
        , p(["What’s going on here? Why do these two terms unify? Well, as far as Prolog is concerned, ", \inline_code("'mia'"), " and ", \inline_code("mia"), " are the same atom. In fact, for Prolog, any atom of the form ", \inline_code("'symbols'"), " is considered the same entity as the atom of the form ", \inline_code("symbols"), ". This can be a useful feature in certain kinds of programs, so don’t forget it."])
        , p(["On the other hand, to the query"])
        , \code_query("'2'  =  2.")
        , p(["Prolog will respond ", \inline_code("no."), " And if you think about the definitions given in ", a(href("/section/1.2"), "Chapter 1"), ", you will see that this has to be the way things work. After all, ", \inline_code("2"), " is a number, but ", \inline_code("'2'"), " is an atom. They simply cannot be the same."])
        , p(["Let’s try an example with a variable:"])
        , \code_query("mia  =  X.")
        , \static_code_block(["X  =  mia", "yes"])
        , p(["Again, this in an easy example: clearly the variable ", \inline_code("X"), " can be unified with the constant ", \inline_code("mia"), ", and Prolog does so, and tells us that it has made this unification. Fine, but how does this follow from our definition?"])
        , p(["The relevant clause here is clause 2. This tells us what happens when at least one of the arguments is a variable. In our example it is the second term which is the variable. The definition tells us unification is possible, and also says that the variable is instantiated to the first argument, namely ", \inline_code("mia"), ". And this, of course, is exactly what Prolog does."])
        , p(["Now for an important example: what happens with the following query?"])
        , \code_query("X  =  Y.")
        , p(["Well, depending on your Prolog implementation, you may just get back the output"])
        , \static_code_block(["?-  X  =  Y.", "yes"])
        , p(["Prolog is simply agreeing that the two terms unify (after all, variables unify with anything, so they certainly unify with each other) and making a note that from now on, X and Y denote the same object, that is, share values."])
        , p(["On the other hand, you may get the following output:"])
        , \static_code_block(["X  =  _5071", "Y  =  _5071", "yes"])
        , p(["What’s going on here? Essentially the same thing. Note that ", \inline_code("_5071"), " is a variable (recall from ", a(href("/section/1.2.3"), "Chapter 1"), " that strings of letters and numbers that start with the underscore character are variables). Now look at clause 2 of the definition of unification. This tells us that when two variables are unified, they share values. So Prolog has created a new variable (namely ", \inline_code("_5071"), ") and from now on both ", \inline_code("X"), " and ", \inline_code("Y"), " share the value of this variable. In effect, Prolog is creating a common variable name for the two original variables. Needless to say, there’s nothing magic about the number ", \inline_code("5071"), ". Prolog just needs to generate a brand new variable name, and using numbers is a handy way to do this. It might just as well generate ", \inline_code("_5075"), ", or ", \inline_code("_6189"), ", or whatever."])
        , p(["Here is another example involving only atoms and variables. How do you think will Prolog respond?"])
        , \code_query("X  =  mia,  X  =  vincent.")
        , p(["Prolog will respond ", \inline_code("no"), ". This query involves two goals, ", \inline_code("X  =  mia"), " and ", \inline_code("X  =  vincent"), " . Taken separately, Prolog would succeed at both of them, instantiating ", \inline_code("X"), " to ", \inline_code("mia"), " in the first case and to ", \inline_code("vincent"), " in the second. And that’s exactly the problem here: once Prolog has worked through the first goal, ", \inline_code("X"), " is instantiated to (and therefore equal to) ", \inline_code("mia"), ", so that it simply can’t unify with ", \inline_code("vincent"), " anymore. Hence the second goal fails. An instantiated variable isn’t really a variable anymore: it has become what it was instantiated with."])
        , p(["Now let’s look at an example involving complex terms:"])
        , \code_query("k(s(g),Y)  =  k(X,t(k)).")
        , \static_code_block(["X  =  s(g)", "Y  =  t(k)", "yes"])
        , p(["Clearly the two complex terms unify if the stated variable instantiations are carried out. But how does this follow from the definition? Well, first of all, clause 3 has to be used here because we are trying to unify two complex terms. So the first thing we need to do is check that both complex terms have the same functor and arity. And they do. Clause 3 also tells us that we have to unify the corresponding arguments in each complex term. So do the first arguments, ", \inline_code("s(g)"), " and ", \inline_code("X"), ", unify? By clause 2, yes, and we instantiate ", \inline_code("X"), " to ", \inline_code("s(g)"), ". So do the second arguments, ", \inline_code("Y"), " and ", \inline_code("t(k)"), ", unify? Again by clause 2, yes, and we instantiate ", \inline_code("Y"), " to ", \inline_code("t(k)"), "."])
        , p(["Here’s another example with complex terms:"])
        , \code_query("k(s(g),  t(k))  =  k(X,t(Y)).")
        , \static_code_block(["X  =  s(g)", "Y  =  k", "yes"])
        , p(["It should be clear that the two terms unify if these instantiations are carried out. But can you explain, step by step, how this relates to the definition?"])
        , p(["Here is a last example:"])
        , \code_query("loves(X,X)  =  loves(marcellus,mia).")
        , p(["Do these terms unify? No, they don’t. It’s true that they are both complex terms and have the same functor and arity, but clause 3 also demands that all corresponding arguments have to unify, and that the variable instantiations have to be compatible. This is not the case here. Unifying the first arguments would instantiate ", \inline_code("X"), " with ", \inline_code("marcellus"), ". Unifying the second arguments would instantiate ", \inline_code("X"), " with ", \inline_code("mia"), ". Either way, we’re blocked."])
        ]
    ).
:- end_object.


:- object('2.1.2',
    extends(leaf_section)).
    title("The Occurs Check").
    keyTerms(['occurs check']).

    subcontent(
        [ p(["Unification is a well-known concept, used in several branches of computer science. It has been thoroughly studied, and many unification algorithms are known. But Prolog does ", em("not"), " use a standard unification algorithm when it performs its version of unification. Instead it takes a shortcut. You need to know about this shortcut."])
        , p(["Consider the following query:"])
        , \code_query("father(X)  =  X.")
        , p(["Do these terms unify or not? A standard unification algorithm would say: “No, they don’t”. Why is that? Well, pick any term and instantiate ", \inline_code("X"), " to the term you picked. For example, if you instantiate ", \inline_code("X"), " to ", \inline_code("father(father(butch))"), ", the left hand side becomes ", \inline_code("father(father(father(butch)))"), ", and the right hand side becomes ", \inline_code("father(father(butch))"), ". Obviously these don’t unify. Moreover, it makes no difference what term you instantiate ", \inline_code("X"), " to. No matter what you choose, the two terms cannot possibly be made the same, for the term on the left will always be one symbol longer than the term on the right (the functor ", \inline_code("father"), " on the left will always give it that one extra level). A standard unification algorithm will spot this (we’ll see why shortly when we discuss the occurs check), halt, and tell us no."])
        , p(["The recursive definition of Prolog unification given earlier won’t do this. Because the left hand term is the variable ", \inline_code("X"), ", by clause 2 it decides that the terms ", em("do"), " unify, and (in accordance with clause 2) instantiates ", \inline_code("X"), " to the right hand side, namely ", \inline_code("father(X)"), " . But there’s an ", \inline_code("X"), " in this term, and ", \inline_code("X"), " has been instantiated to ", \inline_code("father(X)"), ", so Prolog realises that ", \inline_code("father(X)"), " is really ", \inline_code("father(father(X))"), ". But there’s an ", \inline_code("X"), " here too, and ", \inline_code("X"), " has been instantiated to ", \inline_code("father(X)"), ", so Prolog realises that ", \inline_code("father(father(X))"), " is really ", \inline_code("father(father(father(X)))"), " , and so on. Having instantiated ", \inline_code("X"), " to ", \inline_code("father(X)"), " , Prolog is committed to carrying out an unending sequence of expansions."])
        , p(["At least, that’s the theory. What happens in practice? Well, with older Prolog implementations, what we’ve just described is exactly what happens. You would get a message like:"])
        , \static_code_block("'Not  enough  memory  to  complete  query!'")
        , p(["and a long string of symbols like:"])
        , \static_code_block([ "X  =  father(father(father(father(father(father"
                             , "     (father(father(father(father(father(father"
                             , "     (father(father(father(father(father(father"
                             , "     (father(father(father(father(father(father"
                             , "     (father(father(father(father(father(father"
                             ])
        , p(["Prolog is desperately ", em("trying"), " to come back with the correctly instantiated terms, but it can’t halt, because the instantiation process is unbounded. From an abstract mathematical perspective, what Prolog is trying to do is sensible. Intuitively, the only way the two terms could be made to unify would be if ", \inline_code("X"), " was instantiated to a term containing an infinitely long string of ", \inline_code("father"), " functors, so that the effect of the extra ", \inline_code("father"), " functor on the left hand side was cancelled out. But the terms we compute with are ", em("finite"), " entities. Infinite terms are an interesting mathematical abstraction, but they’re not something we can work with. No matter how hard Prolog tries, it can never build one."])
        , p(["Now, it’s annoying to have Prolog running out of memory like this, and sophisticated Prolog implementations have found ways of coping more gracefully. Try posing the query ", \inline_code("father(X)  =  X"), " to SWI Prolog or SICStus Prolog. The answer will be something like:"])
        , \static_code_block(["X  =  father(father(father(father(...))))))))", "yes"])
        , p(["That is, these implementations insist that unification ", em("is"), " possible, but they ", em("don’t"), " fall into the trap of actually trying to instantiate a finite term for ", \inline_code("X"), " as the naive implementations do. Instead, they detect that there is a potential problem, halt, declare that unification is possible, and print out a finite representation of an infinite term, like the"])
        , \static_code_block("father(father(father(father(...))))))))")
        , p(["in the previous query. Can you compute with these finite representations of infinite terms? That depends on the implementation. In some systems you cannot do much with them. For example, posing the query"])
        , \code_query("X  =  father(X),  Y  =  father(Y),  X  =  Y.")
        , p(["would result in a crash (note that the ", \inline_code("X = Y"), " demands that we unify two finite representations of infinite terms). Nonetheless, in some modern systems unification works robustly with such representations (for example, both SWI and Sicstus can handle the previous example) so you can actually use them in your programs. However, why you might want to use such representations, and what such representations actually are, are topics that lie beyond the scope of this book."])
        , p(["In short, there are actually ", em("three"), " different responses to the question “does ", \inline_code("father(X)"), " unify with ", \inline_code("X"), "”. There is the answer given by the standard unification algorithm (which is to say no), the response of older Prolog implementations (which is to run amok until they use up the available memory), and the answer given by sophisticated Prolog implementations (which is to say yes, and return a finite representation of an infinite term). In short, there is no ‘right’ answer to this question. What is important is that you understand the difference between standard unification and Prolog unification, and know how the Prolog implementation that you work with handles such examples."])
        , p(["Now, in the practical session at the end of the chapter we ask you to try out such examples with your Prolog interpreter. Here we want to say a little more about the difference between Prolog unification and standard unification. Given the very different ways they handle this example, it may seem that standard unification algorithms and the Prolog approach to unification are inherently different. Actually, they’re not. There is one simple difference between the two algorithms that accounts for their different behaviour when faced with the task of unifying terms like ", \inline_code("X"), " and", \inline_code(""), " father(X). A standard algorithm, when given two terms to unify, first carries out what is known as the occurs check. This means that if it is asked to unify a variable with a term, it first checks whether the variable occurs in the term. If it does, the standard algorithm declares that unification is impossible, for clearly it is the presence of the variable ", \inline_code("X"), " in ", \inline_code("father(X)"), " which leads to the problems discussed earlier. Only if the variable does not occur in the term do standard algorithms attempt to carry out the unification."])
        , p(["To put it another way, standard unification algorithms are ", em("pessimistic"), ". They first carry out the occurs check, and only when they are sure that the situation is safe they do go ahead and actually try to unify the terms. So a standard unification algorithm will never get locked into a situation where it is endlessly trying to instantiate variables, or having to appeal to infinite terms."])
        , p(["Prolog, on the other hand, is ", em("optimistic"), ". It assumes that you are not going to give it anything dangerous. So it takes a shortcut: it omits the occurs check. As soon as you give it two terms, it rushes ahead and tries to unify them. As Prolog is a programming language, this is an intelligent strategy. Unification is one of the fundamental processes that makes Prolog work, so it needs to be carried out as fast as possible. Carrying out an occurs check every time unification is called for would slow it down considerably. Pessimism is safe, but optimism is a lot faster! Prolog can only run into problems if you, the programmer, ask it to do something like unify ", \inline_code("X"), " with ", \inline_code("father(X)"), ". And it is unlikely you will ever (intentionally) ask it to do anything like that when writing a real program."])
        , p(["One final remark. Prolog comes with a built-in predicate that carries out standard unification (that is, unification with the occurs check). The predicate is"])
        , \static_code_block("unify_with_occurs_check/2.")
        , p(["So if we posed the query"])
        , \code_query("unify_with_occurs_check(father(X),X).")
        , p(["we would get the response no."])
        ]
    ).
:- end_object.


:- object('2.1.3',
    extends(leaf_section)).
    title("Programming With Unification").

    subcontent(
        [ p(["As we’ve said, unification is a fundamental operation in Prolog. It plays a key role in Prolog proof search (as we shall soon learn), and this alone makes it vital. However, as you get to know Prolog better, it will become clear that unification is interesting and important in its own right. Indeed, sometimes you can write useful programs simply by using complex terms to define interesting concepts. Unification can then be used to pull out the information you want."])
        , p(["Here’s a simple example of this, due to Ivan Bratko", \footnote('See his book "Prolog Programming for Artificial Intelligence", Addison-Wesley Publishing Company, 1990, second edition, pages 41-43'), ". The following two line knowledge base defines two predicates, namely ", \inline_code("vertical/2"), " and ", \inline_code("horizontal/2"), " , which specify what it means for a line to be vertical or horizontal respectively:"])
        , \code_block("lines", ["vertical(line(point(X,Y),point(X,Z))).", "horizontal(line(point(X,Y),point(Z,Y)))."])
        , p(["Now, at first glance this knowledge base may seem too simple to be interesting: it contains just two facts, and no rules. But wait a minute: the two facts are expressed using complex terms which again have complex terms as arguments. Indeed, there are three levels of terms nested inside terms. Moreover, the deepest level arguments are all variables, so the concepts are being defined in a general way. Maybe it’s not quite as simple as it seems. Let’s take a closer look."])
        , p(["Right down at the bottom level, we have a complex term with functor ", \inline_code("point"), " and two arguments. Its two arguments are intended to be instantiated to numbers: ", \inline_code("point(X,Y)"), " represents the Cartesian coordinates of a point. That is, the ", \inline_code("X"), " indicates the horizontal distance the point is from some fixed point, while the ", \inline_code("Y"), " indicates the vertical distance from that same fixed point."])
        , p(["Now, once we’ve specified two distinct points, we’ve specified a line, namely the line between them. So the two complex terms representing points are bundled together as the two arguments of another complex term with the functor ", \inline_code("line"), ". In effect, we represent a line by a complex term which has two arguments which are complex terms themselves and represent points. We’re using Prolog’s ability to build complex terms to work our way up a hierarchy of concepts."])
        , p(["Being vertical, and being horizontal, are properties of lines. The predicates ", \inline_code("vertical"), " and ", \inline_code("horizontal"), " therefore both take one argument which represents a line. The definition of ", \inline_code("vertical/1"), " simply says: a line that goes between two points that have the same x-coordinate is vertical. Note how we capture the effect of “the same x-coordinate” in Prolog: we simply make use of the same variable ", \inline_code("X"), " as the first argument of the two complex terms representing the points."])
        , p(["Similarly, the definition of ", \inline_code("horizontal/1"), " simply says: a line that goes between two points that have the same y-coordinate is horizontal. To capture the effect of “the same y-coordinate”, we use the same variable ", \inline_code("Y"), " as the second argument of the two complex terms representing the points."])
        , p(["What can we do with this knowledge base? Let’s look at some examples:"])
        , \code_query("lines", "vertical(line(point(1,1),point(1,3))).")
        , p(["This should be clear: the query unifies with the definition of ", \inline_code("vertical/1"), " in our little knowledge base (and in particular, the representations of the two points have the same first argument) so Prolog says yes. Similarly we have:"])
        , \code_query("lines", "vertical(line(point(1,1),point(3,2))).")
        , p(["This query does not unify with the definition of ", \inline_code("vertical/1"), " (the representations of the two points have different first arguments) so Prolog says no."])
        , p(["But we can also ask more general questions:"])
        , \code_query("lines", "horizontal(line(point(1,1),point(2,Y))).")
        , p(["Here our query is: if we want a horizontal line between a point at (1,1), and point whose x-coordinate is 2, what should the y-coordinate of that second point be? Prolog correctly tells us that the y-coordinate should be 1. If we then ask Prolog for a second possibility (note the ", \inline_code(";"), ") it tells us that no other possibilities exist."])
        , p(["Now consider the following:"])
        , \code_query("lines", "horizontal(line(point(2,3),P)).")
        , \static_code_block(["P  =  point(_1972,3) ;", "no"])
        , p(["This query is: if we want a horizontal line between a point at (2,3), and some other point, what other points are permissible? The answer is: any point whose y-coordinate is 3. Note that the ", \inline_code("_1972"), " in the first argument of the answer is a variable, which is Prolog’s way of telling us that any x-coordinate at all will do."])
        , p(["A general remark: the answer given to our last query, namely ", \inline_code("point(_1972,3)"), ", is ", em("structured"), ". That is, the answer is a complex term, representing a sophisticated concept (namely “any point whose y-coordinate is 3”). This structure was built using unification and nothing else: no logical inference (and in particular, no use of modus ponens) was used to produce it. Building structure by unification turns out to be a powerful idea in Prolog programming, far more powerful than this rather simple example might suggest. Moreover, when a program is written that makes heavy use of unification, it is likely to be extremely efficient. We will study a beautiful example in ", a(href("/section/7"), "Chapter 7"), " when we discuss difference lists, which are used to implement Prolog’s built-in grammar system, Definite Clause Grammars."])
        , p(["This style of programming is particularly useful in applications where the important concepts have a natural hierarchical structure (as they did in the simple knowledge base above), for we can then use complex terms to represent this structure, and unification to access it. This way of working plays an important role in computational linguistics, for example, because information about language has a natural hierarchical structure (think of the way sentences can be analysed into noun phrases and verb phrases, and noun phrases analysed into determiners and nouns, and so on)."])
        ]
    ).
:- end_object.
