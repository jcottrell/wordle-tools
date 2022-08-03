#lang racket

(provide get-wordle-day-number
         get-wordle-list)

(require threading   ; ~> and ~>>
         racket/date ; date struct
         "./wordle-list.rkt")

;; Wordle day support

(define (get-wordle-day-number date-of-day)
  (let ([wordle-start-date (date 0 0 0 18 6 2021 0 0 #f 0)])
    (~> (- (date->seconds date-of-day)
           (date->seconds wordle-start-date))
        (/ _ 60)
        (/ _ 60)
        (/ _ 24)
        floor)))

;; Wordle web scraping support for list retrieval

(define (get-wordle-list wordle-page-url)
  (~> wordle-page-url
      get-wordle-js-source-url-from-wordle-page
      first
      get-js-page-string
      parse-into-wordle-list
      list->vector
      vector->immutable-vector))
