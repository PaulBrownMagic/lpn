:- prolog_load_context(directory, Dir),
   asserta(user:file_search_path(html_comp, Dir)).


:- ensure_loaded(html_comp(code_components)).
:- ensure_loaded(html_comp(page_components)).
:- ensure_loaded(html_comp(script_blocks)).
