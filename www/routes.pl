:- module(routes, []).

:- use_module(library(http/http_files)).
:- use_module(www(controllers),
    [ say_hi/1
    , reply_lpn_section/2
    ]
).

http:location(static, '/static', []).
http:location(section, '/section', []).

% Tmp home page
:- http_handler(/, say_hi,  []).

% Book content, X identifies the page
:- http_handler(section(X), reply_lpn_section(X), []).

% Static files
:- http_handler(static(.), http_reply_from_files(www(static), []), [prefix]).
