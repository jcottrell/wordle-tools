#lang racket

(provide date-string->wordle-day
         wordle-day->wordle-answer
         search-word->wordle-day
         wordle-day->date
         date->date-string)

(require threading   ; ~> and ~>>
         "./wordle-date.rkt"
         "./wordle-list.rkt")

(define wordle-answers-key 'wordle-answers-list)
(define wordle-page-url    "https://www.nytimes.com/games/wordle/index.html")

(define (wordle-day->wordle-answer wordle-day)
  (vector-ref (wordle-page-url->wordle-answers wordle-page-url)
              wordle-day))

(define (search-word->wordle-day word)
  (vector-member word (wordle-page-url->wordle-answers wordle-page-url)))
;(search-word->wordle-day "cigar") ; => 1

(define (wordle-page-url->wordle-answers wordle-page-url)
  (~> wordle-page-url
      get-wordle-list
      list->vector
      vector->immutable-vector))
