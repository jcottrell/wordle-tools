#lang racket

(require threading
         racket/date
         "./wordle-lib.rkt")

(~> (current-date)
    get-wordle-day-number
    (vector-ref (get-wordle-list "https://www.nytimes.com/games/wordle/index.html") _))
