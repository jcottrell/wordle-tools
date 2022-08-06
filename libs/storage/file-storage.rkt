#lang racket

(provide store-list
         retrieve-list)

(require racket/date ; file time to date
         threading)  ; ~>

(define storage-directory (string-append (path->string (find-system-path 'orig-dir))
                                         "/cache"))

(define (storage-path-to file-name)
  (string-append storage-directory
                 "/"
                 (symbol->string file-name)
                 ".txt"))

(define (store-list name data)
  (begin (when (not (directory-exists? storage-directory)) (make-directory storage-directory))
         (write-to-file data
                        (storage-path-to name)
                        #:mode 'binary
                        #:exists 'replace)
         data))

; test store-list
;(store-list 'test '(cigar and other words))

(define (retrieve-list name)
  (let ([storage-path (storage-path-to name)])
    (cond [(not (file-exists? storage-path)) '()]
          [(expired-cache?    storage-path)  '()]
          [else (file->value storage-path)])))

(define (expired-cache? storage-path)
  (let ([now (current-date)]
        [file-date (~> storage-path
                       file-or-directory-stat
                       (hash-ref _ 'modify-time-seconds)
                       seconds->date)])
    (or (> (date-year  now) (date-year file-date))
        (> (date-month now) (date-month file-date))
        (> (date-day   now) (date-day   file-date)))))

;; test retrieve-list
#;(let* ([storage-path    (storage-path-to 'test)]
       [file-not-found? (not (file-exists? storage-path))]
       [file-contents   (if file-not-found?
                            '()
                            (retrieve-list 'test))])
  (string-append "Contents: " (if file-not-found?
                                  "<file not found>"
                                  (string-join (map symbol->string file-contents)))))
