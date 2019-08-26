:- {tutor(loader)}.

:- protocol(bodyresp).
  :- public(content//0).
:- end_protocol.


:- object(section,
    implements(bodyresp)).
    :- meta_non_terminal(html_write:html(*)).
    :- public([title/1]).

    :- protected(heading1//0).
    heading1 --> {self(Self), ::title(T)}, html_write:html(h1("~w: ~w"-[Self, T])).

    :- protected(heading2//0).
    heading2 --> {self(Self), ::title(T)}, html_write:html(h2("~w: ~w"-[Self, T])).

:- end_object.


:- object(navigation_section,
    extends(section)).
    :- meta_non_terminal(html_write:html(*)).

    :- private(children/1).

    :- protected(nav_heading//0).
    nav_heading --> { self(Self), ::title(T) },
        html_write:html(div(class(chapter_header),
            [ h2(class(['chapter_num', 'text-right', 'mb-5']), "Chapter ~w"-[Self])
            , h1(class(['chapter_title', 'text-right', 'border-bottom', 'border-dark', 'mb-3']), T)
            ])).

    :- public(navigation_children//0).
    navigation_children --> { ::children(C), this(This) }, html_write:html(ul(class([nav, 'flex-column']), This::nav_item(C))).

    :- public(nav_item//1).
    nav_item([]) --> [].
    nav_item([H|T]) --> {H::title(Title)},
        html_write:html(li(class('nav-item'),
            [ small(H)
            , a([class('pl-3'), href("/section/~w"-[H])], Title)
            ])),
            nav_item(T). % simplified for now
:- end_object.


:- object(chapter,
    extends(navigation_section)).
    :- meta_non_terminal(html_write:html(*)).

    :- private(goals/1).

    :- public(chapter_goals//0).
    chapter_goals --> { ::goals(G), self(Self) },
        html_write:html(div(class(['col-9', 'chapter_goals', 'card', 'bg-light']),
            [ div(class('card-body'),
                [ h5(class('card-title'), "Main goals:")
                , ol(class([goal_list, 'list-group', 'list-group-flush']), Self::to_li(G))
                ])
            ])
        ).
    :- public(to_li//1).
    to_li([]) --> [].
    to_li([H|T]) --> html_write:html(li(class('list-group-item'), H)), to_li(T).


    content --> {self(Self)},
        ::nav_heading,
        html_write:html(div(class(row),
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
    :- meta_non_terminal(html_write:html(*)).

    title("Exercises").

    content --> {self(Self)},
        ::nav_heading,
        html_write:html(div([h5("Exercises: "), Self::navigation_children])).
:- end_object.


:- object(quiz,
    extends(leaf_section)).
    :- public(required_script/1).
:- end_object.


:- object(question_quiz,
    extends(quiz)).
    :- meta_non_terminal(html_write:html(*)).

    :- protected(questions/1).

    :- public(pl_questions//0).
    pl_questions --> { ::questions(Qs), meta::map([In, Out]>>(term_to_atom(In, A), atomic_concat(A, '.', Out)), Qs, As)},
        html_write:html(script([type('text/prolog'), id('questions.pl')], \As)). % \As is list writing shortcut...

:- end_object.


:- object(mcq,
    extends(question_quiz)).
    :- meta_non_terminal(html_write:html(*)).

    :- protected(question_options/1).

    :- private(mcq_quiz//0).
    mcq_quiz --> { self(Self) }, html_write:html(
        [ div(class('col-sm-9'),
            [ div(class('table-responsive'),
                table(class([table, 'table-striped', 'sticky-header']),
                [ thead(class('bg-white'), tr([th([]), Self::th_opt]))
                    , tbody(Self::mcq_questions)
                    ]))
            %, input( [ id(submitbtn), type(button), value("Submit"), class([btn, 'btn-primary', disabled, 'mr-3'])], [])
            %, label( [ for(submitbtn), class('text-muted') ], small("You must be logged in to track your learning"))
            ])
        , div(class('col-sm-3'), ul([class('list-group'), id(feedback)], []))
        , Self::pl_questions
        ]
    ).

    :- public(th_opt//0).
    :- private(th_opt_//1).
    th_opt --> { ::question_options(Opts) }, th_opt_(Opts).
    th_opt_([]) --> [].
    th_opt_([Opt|Tail]) --> html_write:html(th([class('text-center'), scope(col)], Opt)), th_opt_(Tail).

    :- public(mcq_questions//0).
    :- private(mcq_questions_//2).
    mcq_questions --> { ::question_options(Opts), ::questions(Qs) }, mcq_questions_(Opts, Qs).
    mcq_questions_(_, []) --> [].
    mcq_questions_(Opts, [question(Name, _, _)|T]) --> { this(This) },
        html_write:html(tr(
            [ th([class(['text-right']), scope(row)], Name)
            , This::mcq_question(Opts, Name)
            ])
        ),
        mcq_questions_(Opts, T).

    :- public(mcq_question//2).
    mcq_question([], _) --> [].
    mcq_question([Opt|T], Name) -->
        html_write:html(td(class('text-center'), label(class(['btn btn-secondary']), input([type(radio), name(Name), id("~w~w"-[Name, Opt]), value(Opt)], [])))),
        mcq_question(T, Name).

    content -->
        ::heading2,
        ::subcontent,
        :: mcq_quiz.
:- end_object.
