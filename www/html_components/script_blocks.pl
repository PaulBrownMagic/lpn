quiz_script(N, Source) :-
    ako(N, quiz), % all quizzes should define a required_script (in parent class)
    N::required_script(S),
    atom_concat('/static/js/quizzes/', S, Source).


% Scripts for quiz pages
scripts(N) -->
    { quiz_script(N, Source) },
    html(
        [ script([src('/static/js/vendor/jquery-3.4.1.min.js')],[])
        , script([src('/static/js/vendor/jquery.floatThead.min.js')],[])
        , script([src('/static/js/vendor/bootstrap.bundle.min.js')], [])
        , script([src('/static/js/vendor/prism.js')], [])
        , script([src('/static/js/vendor/tau-prolog.js')], [])
        , script([src('/static/js/lpn.js')], [])
        , script([src(Source)], [])
        ]
    ).

% Scripts for non-quiz pages
scripts(N) -->
    { \+ quiz_script(N, _) },
    html(
        [ script([src('/static/js/vendor/jquery-3.4.1.min.js')],[])
        , script([src('/static/js/vendor/bootstrap.bundle.min.js')], [])
        , script([src('/static/js/vendor/prism.js')], [])
        , script([src('/static/js/vendor/tau-prolog.js')], [])
        , script([src('/static/js/lpn.js')], [])
        , script([src('/static/js/interactive_pl.js')], [])
        ]
    ).
