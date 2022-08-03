#lang racket

(provide get-wordle-js-source-url-from-wordle-page
         get-js-page-string
         parse-into-wordle-list)

(require (planet neil/html-parsing:2:0) ; html->xexp
         net/url     ; get-pure-port
         threading   ; ~> and ~>>
         racket/port); port->string

;(get-wordle-js-source-url-from-wordle-page "https://www.nytimes.com/games/wordle/index.html")
(define (get-wordle-js-source-url-from-wordle-page url-of-page)
  (~> url-of-page
      get-html-xexp-from-url
      get-js-source-attributes
      get-js-sources-from-attributes
      get-wordle-url-from-urls))

(define (get-js-page-string url-of-page)
  (~> url-of-page
      string->url
      get-pure-port
      port->string))

(define (parse-into-wordle-list page-string)
  (let ([raw-js-array (regexp-match #rx"=\\[(\\\"cigar\\\".*?)\\]" page-string)])
    (cond [(not raw-js-array) '()]
          [else (~> (second raw-js-array)
                    (string-replace _ "\"" "")
                    (string-split _ ",")
                    (cons "BW - before wordle (for indexing)" _))])))

;;;; get-wordle-js-source-url-from-wordle-page support functions

(define (get-html-xexp-from-url url)
  (~> url
      string->url
      get-pure-port
      html->xexp))

(define (get-js-source-attributes html-xexp)
  (filter has-js-sources
        (rest (fourth (third (cdr html-xexp))))))

(define (has-js-sources child)
  (let* ([tag        (car child)]
         [attributes (member '@   (cadr child))]
         [has-source (and attributes
                          (not (null? (filter (lambda (attribute) (eq? 'src (car attribute))) (cdr attributes)))))])
    (and (eq? tag 'script)
         attributes
         has-source)))

(define (get-js-sources-from-attributes source-attributes)
  (map (lambda (source) (second (third source)))
       (filter (lambda (attribute)
                        (member 'src (map first attribute)))
                      (map cdadr source-attributes))))

(define (get-wordle-url-from-urls urls)
  (filter (lambda (url)
            (string-contains? url "wordle"))
          urls))
