:- {tutor(loader)}.

:- protocol(bodyresp).
  :- public(content//0).
:- end_protocol.


:- object(section,
    implements(bodyresp)).

    :- public([title/1]).

    :- protected(heading1//0).
    heading1 --> {self(Self), ::title(T)}, html_write::html(h1("~w: ~w"-[Self, T])).

    :- protected(heading2//0).
    heading2 --> {self(Self), ::title(T)}, html_write::html(h2("~w: ~w"-[Self, T])).

:- end_object.


:- object(navigation_section,
    extends(section)).

    :- private(children/1).

    :- protected(nav_heading//0).
    nav_heading --> { self(Self), ::title(T) },
        html_write::html(div(class(chapter_header),
            [ h2(class(['chapter_num', 'text-right', 'mb-5']), "Chapter ~w"-[Self])
            , h1(class(['chapter_title', 'text-right', 'border-bottom', 'border-dark', 'mb-3']), T)
            ])).

    :- public(navigation_children//0).
    navigation_children --> { ::children(C), this(This) }, html_write::html(ul(class([nav, 'flex-column']), This::nav_item(C))).

    :- public(nav_item//1).
    nav_item([]) --> [].
    nav_item([H|T]) --> html_write::html(li(class('nav-item'), H)), nav_item(T). % simplified for now

    content --> {self(Self)},
        ::nav_heading,
        html_write::html(div([h5("Exercises: "), Self::navigation_children])).
:- end_object.


:- object(chapter,
    extends(navigation_section)).

    :- private(goals/1).

    :- public(chapter_goals//0).
    chapter_goals --> { ::goals(G), self(Self) },
        html_write::html(div(class(['col-9', 'chapter_goals', 'card', 'bg-light']),
            [ div(class('card-body'),
                [ h5(class('card-title'), "Main goals:")
                , ol(class([goal_list, 'list-group', 'list-group-flush']), Self::to_li(G))
                ])
            ])
        ).
    :- public(to_li//1).
    to_li([]) --> [].
    to_li([H|T]) --> html_write::html(li(class('list-group-item'), H)), to_li(T).


    content --> {self(Self)},
        ::nav_heading,
        html_write::html(div(class(row),
            [ div(class(col),
                [ h5("Sections:")
                , Self::navigation_children
                ])
            , Self::chapter_goals
            ])
        ).
:- end_object.


:- object(node_section,
    extends(navigation_section)).

    :- public(subcontent//0).

    content -->
        ::heading1,
        ::subcontent,
        ::navigation_children.

:- end_object.

:- object(leaf_section,
    extends(section)).

    :- public(subcontent//0).

    content -->
        ::heading2,
        ::subcontent.
:- end_object.


:- object(exercises,
    extends(navigation_section)).
    title("Exercises").
:- end_object.


:- object('1',
    extends(chapter)).
    title("Facts, Rules, and Queries").
    children(['1.1', '1.2', '1.3', '1.4']).
    goals(["To give some simple examples of Prolog programs. This will introduce us to the three basic constructs in Prolog: facts, rules, and queries. It will also introduce us to a number of other themes, like the role of logic in Prolog, and the idea of performing unification with the aid of variables."
          , "To begin the systematic study of Prolog by defining terms, atoms, variables and other syntactic concepts."
          ]).
:- end_object.


:- object('1.1',
    extends(node_section)).
    title("Some Simple Examples").
    children(['1.1.1', '1.1.2', '1.1.3', '1.1.4', '1.1.5']).
    keyTerms(['knowledge base', 'database']).

    subcontent --> html_write::html(
        [ p(["There are only three basic constructs in Prolog: facts, rules, and queries. A collection of facts and rules is called a knowledge base (or a database) and Prolog programming is all about writing knowledge bases. That is, Prolog programs simply ", em("are"), " knowledge bases, collections of facts and rules which describe some collection of relationships that we find interesting."])
        , p(["So how do we ", em("use"), " a Prolog program? By posing queries. That is, by asking questions about the information stored in the knowledge base."])
        , p("Now this probably sounds rather strange. It’s certainly not obvious that it has much to do with programming at all. After all, isn’t programming all about telling a computer what to do? But as we shall see, the Prolog way of programming makes a lot of sense, at least for certain tasks; for example, it is useful in computational linguistics and Artificial Intelligence (AI). But instead of saying more about Prolog in general terms, let’s jump right in and start writing some simple knowledge bases; this is not just the best way of learning Prolog, it’s the only way.")
        ]).
:- end_object.


:- object('1.1.1',
    extends(leaf_section)).
    title("Knowledge Base 1").

    subcontent --> html_write::html(
        [ p(["Knowledge Base 1 (KB1) is simply a collection of facts. Facts are used to state things that are ", em("unconditionally"), " true of some situation of interest. For example, we can state that Mia, Jody, and Yolanda are women, that Jody plays air guitar, and that a party is taking place, using the following five facts:"])
        , \code_block("kb1",
            [ "woman(mia)."
            , "woman(jody)."
            , "woman(yolanda)."
            , "playsAirGuitar(jody)."
            , "party."
            ])
        , p(["This collection of facts is KB1. It is our first example of a Prolog program. Note that the names ", \inline_code("mia"), ", ", \inline_code("jody"), ", and ", \inline_code("yolanda"), ", the properties ", \inline_code("woman"), " and ", \inline_code("playsAirGuitar"), ", and the proposition ", \inline_code("party"), " have been written so that the first letter is in lower-case. This is important; we will see why a little later on."])
        , p("How can we use KB1? By posing queries. That is, by asking questions about the information KB1 contains. Here are some examples. We can ask Prolog whether Mia is a woman by posing the query:")
        , \code_query("kb1", "woman(mia).")
        , p("Prolog will answer")
        , \static_code_block(yes)
        , p(["for the obvious reason that this is one of the facts explicitly recorded in KB1. Incidentally, ", em("we"), " don’t type in the ", \inline_code("?-"), ". This symbol (or something like it, depending on the implementation of Prolog you are using) is the prompt symbol that the Prolog interpreter displays when it is waiting to evaluate a query. We just type in the actual query (for example ", \inline_code("woman(mia)"), " ) followed by ", \inline_code("."), " (a full stop). The full stop is important. If you don’t type it, Prolog won’t start working on the query."])
        , p("Similarly, we can ask whether Jody plays air guitar by posing the following query:")
        , \code_query("kb1", "playsAirGuitar(jody).")
        , p("Prolog will again answer yes, because this is one of the facts in KB1. However, suppose we ask whether Mia plays air guitar:")
        , \code_query("kb1", "playsAirGuitar(mia).")
        , p("We will get the answer")
        , \static_code_block(no)
        , p(["Why? Well, first of all, this is not a fact in KB1. Moreover, KB1 is extremely simple, and contains no other information (such as the ", em("rules"), " we will learn about shortly) which might help Prolog try to infer (that is, deduce) whether Mia plays air guitar. So Prolog correctly concludes that ", \inline_code("playsAirGuitar(mia)"), " does ", em("not"), " follow from KB1."])
        , p("Here are two important examples. First, suppose we pose the query:")
        , \code_query("kb1", "playsAirGuitar(vincent).")
        , p(["Again Prolog answers ", \inline_code("no."), " Why? Well, this query is about a person (Vincent) that it has no information about, so it (correctly) concludes that ", \inline_code("playsAirGuitar(vincent)"), " cannot be deduced from the information in KB1."])
        , p("Similarly, suppose we pose the query:")
        , \code_query("kb1", "tatooed(jody).")
        , p(["Again Prolog will answer ", \inline_code("no."), " Why? Well, this query is about a property (being tatooed) that it has no information about, so once again it (correctly) concludes that the query cannot be deduced from the information in KB1. (Actually, some Prolog implementations will respond to this query with an error message, telling you that the predicate or procedure ", \inline_code("tatooed"), " is not defined; we will soon introduce the notion of predicates.)"])
        , p("Needless to say, we can also make queries concerning propositions. For example, if we pose the query")
        , \code_query("kb1", "party.")
        , p("then Prolog will respond")
        , \static_code_block(yes)
        , p("and if we pose the query")
        , \code_query("kb1", "rockConcert.")
        , p("then Prolog will respond")
        , \static_code_block(no)
        , p("exactly as we would expect.")
        ]
    ).
:- end_object.


:- object('1.3',
    extends(exercises)).
    children(['1.3.1', '1.3.2', '1.3.3', '1.3.4', '1.3.5', '1.3.6', '1.3.7', '1.3.8']).
:- end_object.
