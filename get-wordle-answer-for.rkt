#lang racket

(require threading
         racket/date
         "./libs/wordle-lib.rkt")

(define (get-wordle-answer-for date-string)
  (let* ([date-list        (map string->number (string-split date-string "-"))]
         [year             (first  date-list)]
         [month            (second date-list)]
         [day              (third  date-list)]
         [date-of-interest (date 0 0 0 day month year 0 0 #f 0)])
    (~> date-of-interest
        get-wordle-day-number
        (vector-ref (get-wordle-list "https://www.nytimes.com/games/wordle/index.html") _))))

(define wordle-answer-getter
  (command-line
   #:program "Wordle Answer Finder"
   #:usage-help
   "Retrieves the wordle answer for the date passed in (year-month-date format)"
   #:args(formatted-date)
   (display (string-append "Wordle answer for "
                  formatted-date
                  ": "
                  (get-wordle-answer-for formatted-date)
                  "\n"))))
