:- object(quiz,
    extends(leaf_section)).
    :- public(required_script/1).

    :- public(quiz_heading//0).
    quiz_heading --> ::heading2,
                     ::subcontent.
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

    required_script('mcq.js').

    :- protected(question_options/1).

    :- private(quiz//0).
    quiz --> { self(Self) }, html_write:html(div(class(row),
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
        ])
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

    content --> ::quiz_heading, ::quiz.
:- end_object.


:- object(input_compare_quiz,
    extends(question_quiz)).
    :- meta_non_terminal(html_write:html(*)).

    required_script('input_compare.js').

    :- public(quiz//0).
    quiz --> {self(Self)},
    html_write:html(
        [div(class(row),
            [ div(class('col-sm-9'), form(id(quiz), Self::compare_questions))
            , Self::feedback
            ])
        , Self::pl_questions
        ]).

    :- public(feedback//0).
    feedback --> html_write:html(div(class('col-sm-3'), ul([class('list-group'), id(feedback)], []))).

    :- public(compare_questions//0).
    :- private(compare_questions_//1).
    compare_questions --> { ::questions(Qs) }, compare_questions_(Qs).
    compare_questions_([]) --> [].
    compare_questions_([question(Q, _, _)|T]) --> html_write:html(
        div(class('input-group'),
            [ div(class('input-group-prepend'), span([class('input-group-text'), id(Q)], Q))
            , input([type(text), class('form-control text-monospace'), 'aria-describedby'=Q], [])
            ])
        ),
        compare_questions_(T).

    content --> ::quiz_heading, ::quiz.
:- end_object.


:- object(input_markscheme_quiz,
    extends(input_compare_quiz)).
    :- meta_non_terminal(html_write:html(*)).

    :- private(markscheme/1).

    required_script('input_markscheme.js').

    compare_questions --> { ::questions(Qs) }, mark_questions(Qs).
    mark_questions([]) --> [].
    mark_questions([question(Q, A)|T]) --> {random_id(ID)}, % random_id defined in code_components
        html_write:html([ div(class('input-group'),
                [ div(class('input-group-prepend'), span([class('input-group-text')], Q))
                , input([type(text), class('form-control answer text-monospace text-right'), 'aria-describedby'=Q, id(ID), 'data-answer'=A], [])
                , div(class('input-group-append markscheme collapse'), div(class('input-group-text'), input([type(checkbox), 'aria-label'='Mark prior answer as correct', onclick('validate(~q, this.checked)'-[ID])], [])))
                ])
                , p(class(['form-text', 'text-right', 'markscheme', collapse]), \inline_code(A))
            ]
        ),
        mark_questions(T).

    feedback --> { ::markscheme(M) },
        html_write:html(div([id(markscheme), class(['col'])],
            [ input([type(button), class([btn, 'btn-primary']), value('Check Answers'), onclick('markscheme()')], [])
            , div(class([collapse, markscheme]), M)
            ])
        ).


    random_id(ID) :-
         length(Codes, 12),
         meta::map({random_between(97, 122)}, Codes),
         atom_codes(ID, Codes).
:- end_object.


:- object(offline_markscheme_quiz,
    extends(quiz)).
    :- meta_non_terminal(html_write:html(*)).

    :- private(markscheme/1).

    required_script('markscheme.js').

    :- private(feedback//0).
    feedback --> { ::markscheme(M) },
        html_write:html(div([id(markscheme)],
            [ input([type(button), class([btn, 'btn-primary']), value('Check Answer'), onclick('markscheme()')], [])
            , div(class([collapse, markscheme]), M)
            ])
        ).

    content --> ::quiz_heading, ::feedback.
:- end_object.
