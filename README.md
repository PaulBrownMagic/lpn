# Learn Prolog Now! source text

## New Interactive Version

The intention is to provide this as part of PrologHub, which will be
changing so that the blog is only one part of it. PrologHub is aiming to
be a "goto" place for people learning Prolog, so it will provide this
service as well as cheat-sheets, reading recommendations, topic specific
tutorials and learning projects.

By tracking what is being learnt it is our hope that *Learn Prolog Now!*
can be integrated with the other services such that if we notice someone
taking a project doesn't know something taught in the book we can point
them towards the relevant section.

### Requirements

Requires Logtalk (developing with 3.28.0). This can be installed with
the query:

```
?- pack_install(logtalk).
```

### Running

The web-server is in `www/server.pl`. In the `www` directory I tend to
run `swipl -g serve -s server.pl`

### Directories

- www    contains source and server for website
- www/book contains all the Logtalk Objects that describe the content
- www/html_components contains html components... surprise!


### Web Concerns

#### HTML

We're using termarized HTML, currently copy-pasted and then transformed.
The current websites don't include all the formatting present in the
Latex/Printed Book, so we're adding this back in. It's probably possible
to write a parser that'll take the Latex and spit out termarized HTML,
but it might prove to take longer.

Termarized HTML is being used to create components, such as a code query
or navigation page. Where possible this should be improved upon.

#### CSS

We're strictly using Bootstrap for a professional style and to integrate
into PrologHub. For these reason we're using the same colour scheme.

#### JavaScript

We're using JQuery, as per Bootstraps requirements. We've got `prism.js`
providing client-side syntax highlighting too. Finally there's some
homespun JavaScript to interact with Tau-Prolog. To avoid writing quiz
logic in JavaScript, these are also handed off to Tau-Prolog.

`localStorage is being used` to store the nav-sidebar state between page
loads. This can be cleared with `localStorage.clear()` should it need to
be refreshed.

#### Client-Side Prolog

Tau-Prolog is providing all the Prolog interactivity. Changing the
code-block structure for `\code_query` will likely break the JavaScript
due to how it navigates the DOM.

### Quizzes

There are many types of these... See `book/quizzes.lgt` for the
implemented ones. Each quiz has a `required_script`, which is the
JavaScript to be loaded for the interactivity. These are stored in
`static/js/quizzes/`

### Practice Sessions

It would be nice to provide an in-browser editor for the user. Thought
is required as to whether Tau-Prolog is sufficient for this or if we
should integrate SWISH.

### User Accounts

Besides logging in, we need to integrate user data into the
ontology. When a user requests a resource this will add a triple, when
they successfully complete an assessment this will also add a triple.
Thus we can track what they've been taught and learnt.
`library(persistency)` will be good for this. It also means we can allow
a user to download all their own data (and static ontology) in Prolog
for their own amusement. User account data can be stored in "FOAF"
inspired triples.


----

# Old Version

Not yet deleted as it contains data not yet transferred.


## Directories

	archive		contains old stuff (just for the record)
	web_site	contains sources of OLD website
	prolog		example prolog databases
	text		contains latex sources and produced ps and pdf files
	scripts		contains shell/perl scripts for conversion and pdf production
	www		contains sources of current website

## Scripts

	scripts/_generate_html	converts html from latex sources
	scripts/_run		produces lpn.ps and lpn.pdf

## Character set

The sources are ISO-Latin-1 files. They do not compile after conversion
to UTF-8.  The scripts must be executed under non-UTF-8 locale.
