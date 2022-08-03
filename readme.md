
# Table of Contents

1.  [Wordle Tools](#org353431b)
    1.  [Short list of tools](#org2cb09ad)
    2.  [Running the tools](#org340f954)
    3.  [Potential future tools](#org73ae869)
    4.  [TODO](#orgde976c1)



<a id="org353431b"></a>

# Wordle Tools

Playing with wordle as practice for real life.


<a id="org2cb09ad"></a>

## Short list of tools

-   Answer finder for <span class="underline">today</span>: pull the list of answers and get today&rsquo;s
-   Answer finder for arbitrary date: pass in the date at the command line in year-month-day format and receive the wordle word for that day


<a id="org340f954"></a>

## Running the tools

-   With Racket installed&#x2026;
-   Run with
    `racket get-wordle-for-today.rkt`
    or
    `racket get-wordle-for.rkt "2022-08-01"`
-   Or compile with `raco exe get-wordle-answer-for.rkt` then run with `./get-wordle-answer-for "2022-08-01"`


<a id="org73ae869"></a>

## Potential future tools

-   Check whether a word has already been used (and when).
-   GUI tools (for answer finders).
-   Browser bookmarklet connection to server to help players stay away from mistakenly re-using letters or spaces when they don&rsquo;t want to.
-   Create your own wordle-esque site with just enough differences for legal separation.


<a id="orgde976c1"></a>

## TODO

-   Keep everything in racket to practice app, website, api, etc. design and patterns.
-   Add a database to keep from hitting the website.
-   Create a UI/UX interface via an app and also a website.
-   Make each tool distributable.
-   Add API for allow others to pull words.
-   Add text-message capability.

