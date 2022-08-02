#lang racket

(require threading
         racket/date)

; The idea here is to create a thorough wordle player that ignores the fact
; that it knows today's word and pretends it only knows all previously played
; words. Based on those previously played words and a list of possible 5-letter
; words, it makes a list of guesses until it comes up with the correct word then
; prints all the guesses that lead to it.

#;(~> "https://www.nytimes.com/games/wordle/index.html"
    get-wordle-javascript
    get-wordle-list
    (get-alphabet-stats _ today's-date)
    (compile-guesses _ '()))

#;(get-most-probable-word alphabet-stats words-guessed-so-far)

(define (get-wordle-javascript wordle-url)
  "https://www.nytimes.com/games-assets/v2/wordle.5cacc604b8014d7ad8fdf4073b49ead4c1615253.js")

(define (get-wordle-list javascript-file-string)
  (vector-immutable "BW - before wordle" "cigar" "rebut" "sissy" "humph" "awake" "blush" "focal" "evade" "naval" "serve" "heath" "dwarf"))

(define (get-alphabet-stats all-possible-words)
    '())

(define (get-wordle-day-number date-of-day)
  (let ([wordle-start-date (date 0 0 0 18  6     2021 0 0 #f 0)])
    (~> (- (date->seconds date-of-day)
           (date->seconds wordle-start-date))
        (/ _ 60)
        (/ _ 60)
        (/ _ 24)
        floor)))

;;(get-wordle-day-number (date 0 0 0 22 6 2022 0 0 #f 0)); => 369

(define (get-wordle-day-number-today)
  (get-wordle-day-number (current-date)))

(define (get-wordle-for-today)
  (vector-ref (get-wordle-list "")
              (get-wordle-day-number-today)))

(define (get-wordle-for-date date-of-day)
  (vector-ref (get-wordle-list "")
              (get-wordle-day-number date-of-day)))

(define (get-wordle-by-number wordle-day-number)
  (vector-ref (get-wordle-list "")
              wordle-day-number))
