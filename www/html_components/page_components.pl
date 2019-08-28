% Top navbar with breadcrumb nav
navbar(N) -->
    html(nav(class([navbar, 'justify-content-start', 'navbar-dark', 'bg-dark', 'fixed-top']),
    [ button([class('navbar-toggler mr-2'), type(button), 'data-toggle'=collapse, 'data-target'='#sidenav', 'aria-controls'="sidenav", 'aria-expanded'=false, 'aria-label'="Toggle book navigation", onclick("toggleshowingbooknav()")], span([], [&("#128214")]))
    , a([class('navbar-brand'), href('/')], "Learn Prolog Now!")
    , nav(class('navbar-expand-md'),
        [ button([class('navbar-toggler'), type(button), 'data-toggle'=collapse, 'data-target'="#navbarMain", 'aria-controls'="navbarMain", 'aria-expanded'=false, 'aria-label'="Toggle navigation"], span([class('navbar-toggler-icon')],[]))
        , div([class([collapse, 'navbar-collapse']), id(navbarMain)],
              [ ul(class(['navbar-nav', 'mr-auto']),
                   [ li(['aria-label'=breadcrumb], ol(class('breadcrumb mb-0'), \breadcrumbs(N, N)))
                   , \child_or_sibling(N)
                   ])
              ])
        ])
    ])
).


breadcrumbs(N, O) -->
    { dif(N, O), \+ has_parent(N, _), N::title(T) },
    html(li([class('breadcrumb-item'), aria-current=page], a([href("/section/~w"-[N])], "~w: ~w"-[N, T]))).
breadcrumbs(N, N) -->
    { \+ has_parent(N, _), N::title(T) },
    html(li([class('breadcrumb-item active'), aria-current=page], "~w: ~w"-[N, T])).
breadcrumbs(N, O) -->
    { dif(N, O), has_parent(N, P), N::title(T) },
    breadcrumbs(P, O),
    html(li([class('breadcrumb-item'), aria-current=page], a([href("/section/~w"-[N])], "~w: ~w"-[N, T]))).
breadcrumbs(N, N) -->
    { has_parent(N, P), N::title(T) },
    breadcrumbs(P, N),
    html(li([class('breadcrumb-item active'), aria-current=page], "~w: ~w"-[N, T])).

child_or_sibling(N) --> % child
    { has_parent(C, N), C::title(T) },
    cs_btn(C, T).
child_or_sibling(N) --> % sibling
    { children(_, Cs), sibling(N, S, Cs), S::title(T) },
    cs_btn(S, T).
child_or_sibling(N) --> % uncle/aunt with greatness
    { has_parent(N, P), has_ancestor(P, GP), has_parent(C, GP), C @> P, C::title(T) },
    cs_btn(C, T).
child_or_sibling(_) --> []. % The last item in the tree
cs_btn(N, T) -->
    html(li([class('nav-item btn btn-info btn-sm ml-2'), aria-current=page], a([class('nav-link text-white'), href("/section/~w"-[N])], [&(raquo), ' ', "~w: ~w"-[N, T]]))).

children(N, Children) :-
    current_object(N),
    N::current_predicate(children/1),
    N::children(Children).

sibling(A, B, [A, B|_]) :- !.
sibling(A, B, [_|T]) :-
    sibling(A, B, T).

has_ancestor(C, A) :-
    has_parent(C, A).
has_ancestor(C, A):-
    has_parent(C, P),
    has_ancestor(P, A).
has_parent(C, P) :-
    children(P, Cs),
    member(C, Cs).

sidenav --> html(
    ul([id(booknav), class(['list-group', 'sticky-top'])],
        [ li(class(['pl-2', 'list-group-item', 'nav-item']), a([class(['nav-link']), href('/')], "Learn Prolog Now!"))
        , \sidenav_items(2, ['1']) %['0.1', '0.2', '1'])
        ])
     ).
sidenav_items(_, []) --> [].
sidenav_items(M, [H|T]) --> sidenav_item(M, H), sidenav_items(M, T).

% Has children
sidenav_item(M, N) --> { children(N, C), N::title(Title), succ(M, NM) },
    html(
        [ li([class(["pl-~w"-[M], 'list-group-item', 'nav-item', 'p-1'])], [ span([class(caret), onclick("expand_book_nav(this)")], []), \sidenav_a(N, Title)])
        , ul(class([nested, collapse, 'list-group']), \sidenav_items(NM, C))
        ]
    ).
% No children
sidenav_item(M, N) -->
    { \+ children(N, _), N::title(Title) },
    html(li(class(["pl-~w"-[M], 'list-group-item', 'nav-item', 'p-1']), \sidenav_a(N, Title))).

sidenav_a(N, T) -->
    html(a([class(['nav-link', 'd-inline']), id("n~w"-[N]), href("/section/~w"-[N])], "~w: ~w"-[N, T])).


html_write:footnote(Content) -->
    html(small(class('text-primary'), span([class(footnote), 'data-toggle'=tooltip, title(Content)], []))).

html_write:diagram(Src, Alt) --> { atom_concat('/static/images/', Src, Img) },
    html(img([class(['mx-auto', 'd-block', diagram]), alt(Alt), src(Img)], [])).
