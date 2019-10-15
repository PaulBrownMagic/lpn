:- object('5.1',
    extends(leaf_section)).

    title("Arithmetic in Prolog").
    keyTerms([]).

    subcontent(
        [ p("Prolog provides a number of basic arithmetic tools for manipulating integers (that is, numbers of the form ...-3, -2, -1, 0, 1, 2, 3, 4...). Most Prolog implementation also provide tools for handling real numbers (or floating point numbers) such as 1.53 or 6.35 × 10^5 , but we’re not going to discuss these, for they are not particularly useful for the symbolic processing tasks discussed in this book. Integers, on the other hand, are useful in connection with symbolic tasks (we use them to state the length of lists, for example) so it is important to understand how to work with them. We’ll start by looking at how Prolog handles the four basic operations of addition, multiplication, subtraction, and division.")
        , \table(["Arithmetic examples", "Prolog Notation"],
                [ ["6 + 2 = 8",	"8  is  6+2."]
                , ["6 ∗ 2 = 12", "12  is  6*2."]
                , ["6 − 2 = 4", "4  is  6-2."]
                , ["6 − 8 = − 2", "-2  is  6-8."]
                , ["6 ÷ 2 = 3", "3  is  6//2."]
                , ["7 ÷ 2 = 3", "3  is  7//2."]
                , ["1 is the remainder when 7 is divided by 2", "1  is  mod(7,2)."]
                ])
        , p(["Note that as we are working with integers, division gives us back an integer answer. Thus 7 ÷ 2 gives 3 as an answer, leaving remainder 1."])
        , p(["Posing the following queries yields the following responses:"])
        , \code_query("8  is  6+2.")
        , \code_query("12  is  6*2.")
        , \code_query("-2  is  6-8.")
        , \code_query("3 is  6//2.")
        , \code_query("3.0 is  6/2.")
        , \code_query("1 is  mod(7,2).")
        , p(["More importantly, we can work out the answers to arithmetic questions by using variables. For example:"])
        , \code_query("X  is  6+2.")
        , \code_query("X  is  6*2.")
        , \code_query("R  is  mod(7,2).")
        , p(["Moreover, we can use arithmetic operations when we define predicates. Here’s a simple example. Let’s define a predicate add_3_and_double/2 whose arguments are both integers. This predicate takes its first argument, adds three to it, doubles the result, and returns the number obtained as the second argument. We define this predicate as follows:"])
        , \code_block("adddbl", ["add_3_and_double(X,Y)  :-  Y  is  (X+3)*2."])
        , p(["And indeed, this works:"])
        , \code_query("adddbl", "add_3_and_double(1,X).")
        , \code_query("adddbl", "add_3_and_double(2,X).")
        , p(["One other thing. Prolog understands the usual conventions we use for disambiguating arithmetical expressions. For example, when we write 3 + 2 × 4 we mean 3 + (2 × 4) and not (3 + 2) × 4, and Prolog knows this convention:"])
        , \code_query("X  is  3+2*4.")
        ]
    ).
:- end_object.

