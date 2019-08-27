:- use_module(library(logtalk)).
:- use_module(library(http/html_write)).
:- ensure_loaded(html_components/code_components).

% :- meta_predicate(html_write:html(2,*,*)).

:- multifile(html_write:expand//1).
html_write:expand(Object::Closure, Arg1, Arg2) :-
    callable(Closure),
    Closure =.. [Functor| Args],
    append(Args, [Arg1, Arg2], FullArgs),
    Message =.. [Functor| FullArgs],
    Object::Message.

body_lgt(N) -->
    html(N::content).

ako(A, B) :-
    extends_object(A, B).
ako(A, B) :-
    extends_object(A, Z),
    ako(Z, B).

:- initialization((
	logtalk_load(
        [ library(metapredicates_loader) % meta::map
        , 'book/sections'
        , 'book/quizzes'
        , 'book/book'
        ],
        [ % required file specific compiler options
        ])
)).
