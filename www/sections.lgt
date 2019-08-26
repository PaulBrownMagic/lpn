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
    nav_item([H|T]) --> {H::title(Title)},
        html_write::html(li(class('nav-item'),
            [ small(H)
            , a([class('pl-3'), href("/section/~w"-[H])], Title)
            ])),
            nav_item(T). % simplified for now


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


:- object(practice,
    extends(section)).

    :- public(subcontent//0).

    title("Practical Session").

    content -->
        ::heading1,
        ::subcontent.

:- end_object.


:- object(exercises,
    extends(navigation_section)).
    title("Exercises").
:- end_object.
