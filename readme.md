
# Table of Contents

1.  [Wordle Tools](#org665a29a)
    1.  [Short list of tools](#orgecd898d)
    2.  [Running the tools](#org154ad12)
    3.  [Potential future tools](#org04ad0f0)
    4.  [TODONEs](#org853ea07)
    5.  [TODO](#org6d37bf4)



<a id="org665a29a"></a>

# Wordle Tools

Playing with wordle as practice for real life.


<a id="orgecd898d"></a>

## Short list of tools

-   Answer finder for <span class="underline">today</span> or any arbitrary date: pull the list of answers and get the requested answer (nothing passed in means <span class="underline">today</span>, arbitrary dates should have the form yyyy-mm-dd)


<a id="org154ad12"></a>

## Running the tools

-   With Racket installed&#x2026;
-   Run with
    `racket get-wordle-answer.rkt`
    or
    `racket get-wordle-answer.rkt "2022-08-01"`
-   Or compile with `raco exe get-wordle-answer.rkt` then run with `./get-wordle-answer "2022-08-01"`


<a id="org04ad0f0"></a>

## Potential future tools

-   Check whether a word has already been used (and when).
-   GUI tools (for answer finders).
-   Browser bookmarklet connection to server to help players stay away from mistakenly re-using letters or spaces when they don&rsquo;t want to.
-   Auto-guesser that will allow developers to add their own set of specially named functions to guess answers, essentially allowing them to test their own play strategies.
-   Create your own wordle-esque site with just enough differences for legal separation.


<a id="org853ea07"></a>

## TODONEs

-   Added storage interface (rudimentary) and implemented it in with file storage first.


<a id="org6d37bf4"></a>

## TODO

-   Keep everything in racket to practice app, website, api, etc. design and patterns.
-   Implement storage interface with database storage.
-   Create a UI/UX interface via an app and also a website.
-   Make each tool distributable.
-   Add API for allow others to pull words.
-   Add text-message capability.

