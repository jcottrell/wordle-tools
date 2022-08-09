#lang racket

(provide date-string->wordle-day
         wordle-day->date
         date->date-string)

(require threading   ; ~> and ~>>
         racket/date); date struct

(define wordle-start-date (date 0 0 0 18 6 2021 0 0 #f 0))

(define (date-string->wordle-day date-string)
  (let* ([date-of-interest (if (non-empty-string? date-string)
                               (date-string->date date-string)
                               (current-date))])
    (date->wordle-day date-of-interest)))

(define (date-string->date date-string)
  (let* ([date-list        (map string->number (string-split date-string "-"))]
         [year             (first  date-list)]
         [month            (second date-list)]
         [day              (third  date-list)])
    (date 0 0 0 day month year 0 0 #f 0)))

(define (date->wordle-day date-of-day)
  (~> (- (date->seconds date-of-day)
         (date->seconds wordle-start-date))
      (/ _ 60)
      (/ _ 60)
      (/ _ 24)
      floor))

(define (date->date-string date-to-format)
  (string-join (list (number->string (date-year  date-to-format))
                     (~a (date-month date-to-format) #:min-width 2 #:align 'right #:left-pad-string "0")
                     (~a (date-day   date-to-format) #:min-width 2 #:align 'right #:left-pad-string "0"))
               "-"))

(define (wordle-day->date wordle-day)
  (let ([days-after-start (* 24 60 60 wordle-day)]
        [start-seconds    (date->seconds wordle-start-date)])
    (~> (+ days-after-start
           start-seconds)
        seconds->date)))

(define (date-pad subject)
  (if (= 2(string-length subject))
      subject
      (string-append "0" subject)))
;(wordle-day->date 414)
;(date->date-string (wordle-day->date 414))
