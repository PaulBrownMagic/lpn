:- multifile frame/2.

:- ensure_loaded(chapter1).
:- ensure_loaded(chapter2).

frame('0.1',
    [ ako-'FrontMatter'
    , title-'Preface'
    ]
).

frame('0.2',
    [ ako-'FrontMatter'
    , title-'Introduction'
    ]
).
