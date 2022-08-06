#lang racket

(provide date-string->wordle-day
         get-wordle-answer-for)

(require threading   ; ~> and ~>>
         "./wordle-date.rkt"
         "./wordle-list.rkt")

(define wordle-answers-key 'wordle-answers-list)

(define (get-wordle-answer-for wordle-page-url wordle-day)
  (vector-ref (wordle-page-url->wordle-answers wordle-page-url)
              wordle-day))

(define (wordle-page-url->wordle-answers wordle-page-url)
  (~> wordle-page-url
      get-wordle-list
      list->vector
      vector->immutable-vector))
