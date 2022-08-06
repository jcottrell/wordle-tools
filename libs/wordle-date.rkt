#lang racket

(provide date-string->wordle-day)

(require threading   ; ~> and ~>>
         racket/date); date struct

(define (date-string->wordle-day date-string)
  (let* ([date-of-interest (if (non-empty-string? date-string)
                               (date-string->date date-string)
                               (current-date))])
    (get-wordle-day-number date-of-interest)))

(define (date-string->date date-string)
  (let* ([date-list        (map string->number (string-split date-string "-"))]
         [year             (first  date-list)]
         [month            (second date-list)]
         [day              (third  date-list)])
    (date 0 0 0 day month year 0 0 #f 0)))

(define (get-wordle-day-number date-of-day)
  (let ([wordle-start-date (date 0 0 0 18 6 2021 0 0 #f 0)])
    (~> (- (date->seconds date-of-day)
           (date->seconds wordle-start-date))
        (/ _ 60)
        (/ _ 60)
        (/ _ 24)
        floor)))
