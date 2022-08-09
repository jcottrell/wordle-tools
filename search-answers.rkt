#lang racket

(require threading
         racket/date
         "./libs/wordle-lib.rkt")

(define wordle-answer-getter
  (command-line
   #:program "Wordle Answer Search"
   #:usage-help
   "Searches the wordle answers for the word entered and shows its date and wordle day."
   #:args (search-word)
   (let ([wordle-day (search-word->wordle-day search-word)])
     (displayln (if wordle-day
                    (let* ([search-date  (wordle-day->date  wordle-day)]
                           [after-today? (> (date->seconds  search-date) (date->seconds (current-date)))]
                           [same-date    (date->date-string search-date)])
                      (string-append "Wordle answer "

                                     search-word
                                     (if after-today? " will appear" " appeared")
                                     " on " same-date " (" (number->string wordle-day) ")"))
                    (string-append "Wordle will not use "
                                   search-word
                                   " as an answer"))))))
