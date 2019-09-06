:- object('4.1',
    extends(leaf_section)).

    title("Lists").
    keyTerms(['elements', 'length', 'empty list', 'head', 'tail', 'anonymous variable']).

    subcontent(
        [ p(["As its name suggests, a list is just a plain old list of items. Slightly more precisely, it is a finite sequence of elements. Here are some examples of lists in Prolog:"])
        , \static_code_block(
            [ '[mia,  vincent,  jules,  yolanda]'
            , ''
            , '[mia,  robber(honey_bunny),  X,  2,  mia]'
            , ''
            , '[]'
            , ''
            , '[mia,  [vincent,  jules],  [butch,  girlfriend(butch)]]'
            , ''
            , '[[],  dead(z),  [2,  [b,  c]],  [],  Z,  [2,  [b,  c]]]'
            ])
        , p(["We can learn some important things from these examples."])
        , ol([ li(["We can specify lists in Prolog by enclosing the elements of the list in square brackets (that is, the symbols ", \inline_code("["), " and ", \inline_code("]"), "). The elements are separated by commas. For example, the first list shown above, ", \inline_code("[mia, vincent, jules, yolanda]"), ", is a list with four elements, namely ", \inline_code("mia"), ", ", \inline_code("vincent"), ", ", \inline_code("jules"), ", and ", \inline_code("yolanda"), ". The length of a list is the number of elements it has, so our first example is a list of length four."])
             , li(["From ", \inline_code("[mia, robber(honey_bunny), X, 2, mia]"), ", our second example, we learn that all sorts of Prolog objects can be elements of a list. The first element of this list is ", \inline_code("mia"), ", an atom; the second element is ", \inline_code("robber(honey_bunny)"), ", a complex term; the third element is ", \inline_code("X"), ", a variable; the fourth element is ", \inline_code("2"), ", a number. Moreover, we also learn that the same item may occur more than once in the same list: for example, the fifth element of this list is ", \inline_code("mia"), ", which is same as the first element."])
             , li(["The third example shows that there is a special list, the empty list. The empty list (as its name suggests) is the list that contains no elements. What is the length of the empty list? Zero, of course (for the length of a list is the number of members it contains, and the empty list contains nothing)."])
             , li(["The fourth example teaches us something extremely important: lists can contain other lists as elements. For example, the second element of"
               , \static_code_block("[mia,  [vincent,  jules],  [butch,girlfriend(butch)]")
               , "is ", \inline_code("[vincent, jules]"), ". The third is ", \inline_code("[butch, girlfriend(butch)]"), "."
               , "What is the length of the fourth list? The answer is: three. If you thought it was five (or indeed, anything else) you’re not thinking about lists in the right way. The elements of the list are the things between the outermost square brackets separated by commas. So this list contains ", em("three"), " elements: the first element is ", \inline_code("mia"), ", the second element is ", \inline_code("[vincent, jules]"), ", and the third element is ", \inline_code("[butch, girlfriend(butch)]"), "."
               ])
             , li(["The last example mixes all these ideas together. We have here a list which contains the empty list (in fact, it contains it twice), the complex term ", \inline_code("dead(z)"), ", two copies of the list ", \inline_code("[2, [b, c]]"), ", and the variable ", \inline_code("Z"), ". Note that the third (and the last) elements are lists which themselves contain lists (namely ", \inline_code("[b, c]"), ")."])
             ])
            , p(["Now for an important point. Any non-empty list can be thought of as consisting of two parts: the head and the tail. The head is simply the first item in the list; the tail is everything else. To put it more precisely, the tail is the list that remains when we take the first element away; that is, ", em("the tail of a list is always a list"), ". For example, the head of"])
            , \static_code_block("[mia,  vincent,  jules,  yolanda]")
        , p(["is ", \inline_code("mia"), " and the tail is  ", \inline_code("[vincent, jules, yolanda]"), ". Similarly, the head of"])
        , \static_code_block("[[],  dead(z),  [2,  [b,  c]],  [],  Z,  [2,  [b,  c]]]")
        , p(["is ", \inline_code("[]"), ", and the tail is ", \inline_code("[dead(z), [2, [b, c]], [], Z, [2, [b, c]]]"), ". And what are the head and the tail of the list ", \inline_code("[dead(z)]"), "? Well, the head is the first element of the list, which is ", \inline_code("dead(z)"), ", and the tail is the list that remains if we take the head away, which, in this case, is the empty list ", \inline_code("[]"), "."])
        , p(["What about the empty list? It has neither a head nor a tail. That is, the empty list has no internal structure; for Prolog, ", \inline_code("[]"), " is a special, particularly simple, list. As we shall learn when we start writing recursive list processing programs, this fact plays an important role in Prolog programming."])
        , p(["Prolog has a special built-in operator ", \inline_code("|"), " which can be used to decompose a list into its head and tail. It is important to get to know how to use ", \inline_code("|"), " , for it is a key tool for writing Prolog list manipulation programs."])
        , p(["The most obvious use of ", \inline_code("|"), " is to extract information from lists. We do this by using ", \inline_code("|"), " together with unification. For example, to get hold of the head and tail of ", \inline_code("[mia, vincent, jules, yolanda]"), " we can pose the following query:"])
        , \code_query("[Head|Tail]  =  [mia,  vincent,  jules,  yolanda].")
        , p(["That is, the head of the list has become bound to ", \inline_code("Head"), " and the tail of the list has become bound to ", \inline_code("Tail"), ". Note that there is nothing special about ", \inline_code("Head"), " and ", \inline_code("Tail"), ", they are simply variables. We could just as well have posed the query:"])
        , \code_query("[X|Y]  =  [mia,  vincent,  jules,  yolanda].")
        , p(["As we mentioned above, only non-empty lists have heads and tails. If we try to use ", \inline_code("|"), " to pull ", \inline_code("[]"), " apart, Prolog will fail:"])
        , \code_query("[X|Y]  =  [].")
        , p(["That is, Prolog treats ", \inline_code("[]"), " as a special list. This observation is extremely important. We’ll see why later."])
        , p(["Let’s look at some other examples. We can extract the head and tail of the following list just as we saw above:"])
        , \code_query("[X|Y]  =  [[],  dead(z),  [2,  [b,  c]],  [],  Z].")
        , \static_code_block(
            [ '?-  [X|Y]  =  [[],  dead(z),  [2,  [b,  c]],  [],  Z].'
            ,  ''
            , 'X  =  []'
            , 'Y  =  [dead(z),[2,[b,c]],[],_7800]'
            , 'Z  =  _7800'
            , 'yes'
            ])
        , p(["That is: the head of the list is bound to ", \inline_code("X"), ", the tail is bound to ", \inline_code("Y"), ". (We also learn that Prolog has bound ", \inline_code("Z"), " to the internal variable ", \inline_code("_7800"), ".)"])
        , p(["But we can do a lot more with ", \inline_code("|"), "; it really is a flexible tool. For example, suppose we wanted to know what the first ", em("two"), " elements of the list were, and also the remainder of the list after the second element. Then we’d pose the following query:"])
        , \code_query("[X, Y | W]  =  [[],  dead(z),  [2,  [b,  c]],  [],  Z].")
        , p(["That is, the head of the list is bound to ", \inline_code("X"), ", the second element is bound to ", \inline_code("Y"), ", and the remainder of the list after the second element is bound to ", \inline_code("W"), " (that is, ", \inline_code("W"), " is the list that remains when we take away the first two elements). So ", \inline_code("|"), " can not only be used to split a list into its head and its tail, we can also use it to split a list at any point. To the left of ", \inline_code("|"), " we simply indicate how many elements we want to take away from the front of the list, and then to right of the ", \inline_code("|"), " we will get what remains."])
        , p(["This is a good time to introduce the anonymous variable. Suppose we were interested in getting hold of the second and fourth elements of the list:"])
        , \static_code_block("[[],  dead(z),  [2,  [b,  c]],  [],  Z].")
        , p(["Now, we could find out like this:"])
        , \code_query("[X1, X2, X3, X4|Tail] = [[], dead(z), [2, [b, c]], [], Z].")
        , p(["Ok, we have got the information we wanted: the values we are interested in are bound to the variables ", \inline_code("X2"), " and ", \inline_code("X4"), ". But we’ve got a lot of other information too (namely the values bound to ", \inline_code("X1"), " , ", \inline_code("X3"), " and ", \inline_code("Tail"), "). And perhaps we’re not interested in all this other stuff. If so, it’s a bit silly having to explicitly introduce variables ", \inline_code("X1"), ", ", \inline_code("X3"), " and ", \inline_code("Tail"), " to deal with it. And in fact, there is a simpler way to obtain ", em("only"), " the information we want: we can pose the following query instead:"])
        , \code_query("[_, X, _, Y|_] = [[], dead(z), [2, [b, c]], [], Z].")
        , p(["The ", \inline_code("_"), " symbol (that is, underscore) is the anonymous variable. We use it when we need to use a variable, but we’re not interested in what Prolog instantiates the variable to. As you can see in the above example, Prolog didn’t bother telling us what ", \inline_code("_"), " was bound to. Moreover, note that each occurrence of ", \inline_code("_"), " is ", em("independent"), ": each is bound to something different. This couldn’t happen with an ordinary variable of course, but then the anonymous variable isn’t meant to be ordinary. It’s simply a way of telling Prolog to bind something to a given position, completely independently of any other bindings."])
        , p(["Let’s look at one last example. The third element of our working example is a list (namely ", \inline_code("[2, [b, c]]"), "). Suppose we wanted to extract the tail of this internal list, and that we are not interested in any other information. How could we do this? As follows:"])
        , \code_query("[_,_,[_|X]|_] = [[], dead(z), [2, [b, c]], [], Z, [2, [b, c]]].")
        ]
    ).
:- end_object.

