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


:- object('1.1.1',
    extends(leaf_section)).
    title("Knowledge Base 1").
    keyTerms(['facts', 'queries', 'infer', 'deduce']).

    subcontent --> html_write::html(
        [ p(["Knowledge Base 1 (KB1) is simply a collection of facts. Facts are used to state things that are ", em("unconditionally"), " true of some situation of interest. For example, we can state that Mia, Jody, and Yolanda are women, that Jody plays air guitar, and that a party is taking place, using the following five facts:"])
        , \code_block("kb1",
            [ "woman(mia)."
            , "woman(jody)."
            , "woman(yolanda)."
            , "playsAirGuitar(jody)."
            , "party."
            ])
        , p(["This collection of facts is KB1. It is our first example of a Prolog program. Note that the names ", \inline_code("mia"), ", ", \inline_code("jody"), ", and ", \inline_code("yolanda"), ", the properties ", \inline_code("woman"), " and ", \inline_code("playsAirGuitar"), ", and the proposition ", \inline_code("party"), " have been written so that the first letter is in lower-case. This is important; we will see why a little later on."])
        , p("How can we use KB1? By posing queries. That is, by asking questions about the information KB1 contains. Here are some examples. We can ask Prolog whether Mia is a woman by posing the query:")
        , \code_query("kb1", "woman(mia).")
        , p("Prolog will answer")
        , \static_code_block(yes)
        , p(["for the obvious reason that this is one of the facts explicitly recorded in KB1. Incidentally, ", em("we"), " don’t type in the ", \inline_code("?-"), ". This symbol (or something like it, depending on the implementation of Prolog you are using) is the prompt symbol that the Prolog interpreter displays when it is waiting to evaluate a query. We just type in the actual query (for example ", \inline_code("woman(mia)"), " ) followed by ", \inline_code("."), " (a full stop). The full stop is important. If you don’t type it, Prolog won’t start working on the query."])
        , p("Similarly, we can ask whether Jody plays air guitar by posing the following query:")
        , \code_query("kb1", "playsAirGuitar(jody).")
        , p("Prolog will again answer yes, because this is one of the facts in KB1. However, suppose we ask whether Mia plays air guitar:")
        , \code_query("kb1", "playsAirGuitar(mia).")
        , p("We will get the answer")
        , \static_code_block(no)
        , p(["Why? Well, first of all, this is not a fact in KB1. Moreover, KB1 is extremely simple, and contains no other information (such as the ", em("rules"), " we will learn about shortly) which might help Prolog try to infer (that is, deduce) whether Mia plays air guitar. So Prolog correctly concludes that ", \inline_code("playsAirGuitar(mia)"), " does ", em("not"), " follow from KB1."])
        , p("Here are two important examples. First, suppose we pose the query:")
        , \code_query("kb1", "playsAirGuitar(vincent).")
        , p(["Again Prolog answers ", \inline_code("no."), " Why? Well, this query is about a person (Vincent) that it has no information about, so it (correctly) concludes that ", \inline_code("playsAirGuitar(vincent)"), " cannot be deduced from the information in KB1."])
        , p("Similarly, suppose we pose the query:")
        , \code_query("kb1", "tatooed(jody).")
        , p(["Again Prolog will answer ", \inline_code("no."), " Why? Well, this query is about a property (being tatooed) that it has no information about, so once again it (correctly) concludes that the query cannot be deduced from the information in KB1. (Actually, some Prolog implementations will respond to this query with an error message, telling you that the predicate or procedure ", \inline_code("tatooed"), " is not defined; we will soon introduce the notion of predicates.)"])
        , p("Needless to say, we can also make queries concerning propositions. For example, if we pose the query")
        , \code_query("kb1", "party.")
        , p("then Prolog will respond")
        , \static_code_block(yes)
        , p("and if we pose the query")
        , \code_query("kb1", "rockConcert.")
        , p("then Prolog will respond")
        , \static_code_block(no)
        , p("exactly as we would expect.")
        ]
    ).
:- end_object.


:- object('1.3',
    extends(exercises)).
    children(['1.3.1', '1.3.2', '1.3.3', '1.3.4', '1.3.5', '1.3.6', '1.3.7', '1.3.8']).
:- end_object.


:- object('1.4',
    extends(practice)).
    subcontent --> html_write::html(
        [ p("Don’t be fooled by the fact that the description of the practical sessions is shorter than the text you have just read; the practical part is definitely the most important. Yes, you need to read the text and do the exercises, but that’s not enough to become a Prolog programmer. To really master the language you need to sit down in front of a computer and play with Prolog — a lot!")
        , p("The goal of the first practical session is for you to become familiar with the basics of how to create and run simple Prolog programs. Now, because there are many different implementations of Prolog, and different operating systems you can run them under, we can’t be too specific here. Rather, what we’ll do is describe in very general terms what is involved in running Prolog, list the practical skills you need to master, and suggest some things for you to do.")
        , p(["The simplest way to run a Prolog program is as follows. You have a file with your Prolog program in it (for example, you may have a file ", \inline_code("kb2.pl"), " which contains the knowledge base KB2). You then start Prolog. Prolog will display its prompt, something like"])
        , \static_code_block("?-")
        , p("which indicates that it is ready to accept a query.")
        , p("Now, at this stage, Prolog knows absolutely nothing about KB2 (or indeed anything else). To see this, type in the command listing , followed by a full stop, and hit return. That is, type")
        , \static_code_block("?-  listing.")
        , p("and press the return key.")
        , p("Now, the listing command is a special built-in Prolog predicate that instructs Prolog to display the contents of the current knowledge base. But we haven’t yet told Prolog about any knowledge bases, so it will just say")
        , \static_code_block("yes")
        , p("This is a correct answer: as yet Prolog knows nothing — so it correctly displays all this nothing and says yes . Actually, with more sophisticated Prolog implementations you may get a little more (for example, the names of libraries that have been loaded; libraries are discussed in Chapter  12 ) but, one way or another, you will receive what is essentially an “I know nothing about any knowledge bases!” answer.")
        , p(["So let’s tell Prolog about KB2. Assuming that you’ve stored KB2 in the file ", \inline_code("kb2.pl"), " , and that this file is in the directory where you’re running Prolog, all you have to type is"])
        , \static_code_block("?-  [kb2].")
        , p(["This tells Prolog to consult the file ", \inline_code("kb2.pl"), " , and load the contents as its new knowledge base. Assuming that ", \inline_code("kb2.pl"), " contains no typos, Prolog will read it in, maybe print out a message saying that it is consulting this file, and then answer:"])
        , \static_code_block("yes")
        , p(["Incidentally, it is common to store Prolog code in files with a ", \inline_code(".pl"), " suffix. It’s an indication of what the file contains (namely Prolog code) and with some Prolog implementations you don’t actually have to type in the ", \inline_code(".pl"), " suffix when you consult a file. Nice — but there is a drawback. Files containing Perl scripts usually have a ", \inline_code(".pl"), " suffix too, and nowadays there are a lot of Perl scripts in use, so this can cause confusion. C’est la vie."])
        , p("If the above doesn’t work, that is, if typing")
        , \static_code_block("?-  [kb2].")
        , p(["produces an error message saying that the file ", \inline_code("kb2"), " does not exist, then you probably haven’t started Prolog from the directory where ", \inline_code("kb2.pl"), " is stored. In that case, you can either stop Prolog (by typing ", \inline_code("halt."), " after the prompt), change to the directory where ", \inline_code("kb2.pl"), " is stored, and start Prolog again. Or you can tell Prolog exactly where to look for ", \inline_code("kb2.pl"), " . To do this, instead of writing only ", \inline_code("kb2"), " between the square brackets, you give Prolog the whole path enclosed in single quotes. For example, you type something like"])
        , \static_code_block("?-  [’home/kris/Prolog/kb2.pl’].")
        , p("or")
        , \static_code_block("?-  [’c:/Documents  and  Settings/Kris/Prolog/kb2.pl’].")
        , p("Ok, so Prolog should now know about all the KB2 predicates. And we can check whether it does by using the listing command again:")
        , \static_code_block("?-  listing.")
        , p("If you do this, Prolog will list (something like) the following on the screen:")
        , \static_code_block(
'listens2Music(mia).
happy(yolanda).
playsAirGuitar(mia):-
     listens2Music(mia).
playsAirGuitar(yolanda):-
     listens2Music(yolanda).
listens2Music(yolanda):-
     happy(yolanda).

yes')
        , p("That is, it will list the facts and rules that make up KB2, and then say yes . Once again, you may get a little more than this, such as the locations of various libraries that have been loaded.")
        , p("Incidentally, listing can be used in other ways. For example, typing")
        , \static_code_block("?-  listing(playsAirGuitar).")
        , p(["simply lists all the information in the knowledge base about the ", \inline_code("playsAirGuitar"), " predicate. So in this case Prolog will display"])
        , \static_code_block(
'playsAirGuitar(mia):-
     listens2Music(mia).
playsAirGuitar(yolanda):-
     listens2Music(yolanda).

yes')
        , p("Well — now you’re ready to go. KB2 is loaded and Prolog is running, so you can (and should!) start making exactly the sort of inquiries we discussed in the text.")
        , p("But let’s back up a little, and summarise a few of the practical skills you will need to master to get this far:")
        , ul([ li("You will need to know some basic facts about the operating system you are using, such as the directory structure it uses. After all, you will need to know how to save the files containing programs where you want them.")
             , li("You will need to know how to use some sort of text editor, in order to write and modify programs. Some Prolog implementations come with built-in text editors, but if you already know a text editor (such as Emacs) you can use this to write your Prolog code. Just make sure that you save your files as simple text files (for example, if you are working under Windows, don’t save them as Word documents).")
             , li("You may want to take example Prolog programs from the internet. So make sure you know how to use a browser to find what you want, and to store the code where you want it.")
             , li("You need to know how to start your version of Prolog, and how to consult files with it.")
             ])
        , p("The sooner you pick up these skills, the better. With them out of the way (which shouldn’t take long) you can start concentrating on mastering Prolog (which will take longer).")
        , p(["But assuming you have mastered these skills, what next? Quite simply, ", em("play with Prolog!"), " Consult the various knowledge bases discussed in the text, and check that the queries discussed really do work the way we said they did. In particular, take a look at KB5 and make sure you understand why you get those peculiar jealousy relations. Try posing new queries. Experiment with the ", \inline_code("listing"), " predicate (it’s a useful tool). Type in the knowledge base used in Exercise  1.5 , and check whether your answers are correct. Best of all, think of some simple situation that interests you, and create a brand-new knowledge base from scratch. "])
        ]
).
:- end_object.
