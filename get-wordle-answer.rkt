#lang racket

(require threading
         racket/date
         "./libs/wordle-lib.rkt")

(define wordle-answer-getter
  (command-line
   #:program "Wordle Answer Finder"
   #:usage-help
   "Retrieves the wordle answer for the date passed in (year-month-day format)"
   #:args parameters
   (let ([display-date (cond [(null? parameters) "today"]
                             [else (first parameters)])]
         [wordle-day   (date-string->wordle-day (if (null? parameters)
                                                    ""
                                                    (first parameters)))])
     (displayln (string-append "Wordle answer for "
                               display-date
                               " (" (number->string wordle-day) "): "
                               (wordle-day->wordle-answer wordle-day))))))
