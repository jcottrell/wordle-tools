#lang racket

;; use file (later sqlite) to store and retrieve lists
(provide store-list
         retrieve-list)

;; sqlite database
;; https://docs.racket-lang.org/db/using-db.html
;; then
;(require "./db-storage.rkt")
;;
;; until then:
(require "./file-storage.rkt")
