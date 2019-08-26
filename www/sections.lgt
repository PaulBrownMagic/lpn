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

    content --> {self(Self)},
        ::heading1,
        ::subcontent,
        ::navigation_children.

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

:- object('1.3',
    extends(exercises)).
    children(['1.3.1', '1.3.2', '1.3.3', '1.3.4', '1.3.5', '1.3.6', '1.3.7', '1.3.8']).
:- end_object.
