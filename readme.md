
# Table of Contents

1.  [Wordle Tools](#orgdb9d435)
    1.  [Short list of tools](#org408a42c)
    2.  [Running the tools](#orgfa4f59d)
    3.  [Potential future tools](#orgbd03d2b)
    4.  [TODONEs](#orgbd3ba5f)
    5.  [TODO](#org161264f)



<a id="orgdb9d435"></a>

# Wordle Tools

Playing with wordle as practice for real life.


<a id="org408a42c"></a>

## Short list of tools

-   Answer finder for <span class="underline">today</span> or any arbitrary date: pull the list of answers and get the requested answer (nothing passed in means <span class="underline">today</span>, arbitrary dates should have the form yyyy-mm-dd)
-   Answer searcher to lookup words that have or will appear as wordle answers. It gives the date and wordle day of when the answer has or will appear.


<a id="orgfa4f59d"></a>

## Running the tools

-   With Racket installed&#x2026;
-   Run with
    `racket get-wordle-answer.rkt`
    or
    `racket get-wordle-answer.rkt "2022-08-01"`
-   Or compile with `raco exe search-answers.rkt` then run with `./search-answers cigar`


<a id="orgbd03d2b"></a>

## Potential future tools

-   GUI tools (for answer finders).
-   Browser bookmarklet connection to server to help players stay away from mistakenly re-using letters or spaces when they don&rsquo;t want to.
-   Auto-guesser that will allow developers to add their own set of specially named functions to guess answers, essentially allowing them to test their own play strategies.
-   Create your own wordle-esque site with just enough differences for legal separation.


<a id="orgbd3ba5f"></a>

## TODONEs

-   Added storage interface (rudimentary) and implemented it in with file storage first.


<a id="org161264f"></a>

## TODO

-   Keep everything in racket to practice app, website, api, etc. design and patterns.
-   Implement storage interface with database storage.
-   Create a UI/UX interface via an app and also a website.
-   Make each tool distributable.
-   Add API for allow others to pull words.
-   Add text-message capability.

