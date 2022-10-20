#lang racket

(provide get-wordle-list)

(require (planet neil/html-parsing:2:0) ; html->xexp
         net/url     ; get-pure-port
         threading   ; ~> and ~>>
         racket/port ; port->string
         "./storage/storage-interface.rkt")

(define (get-wordle-list wordle-page-url)
  (let ([cached-list (retrieve-list 'wordle-answers-list)])
    (if (not (null? cached-list))
        cached-list
        (store-list 'wordle-answers-list
                    (get-latest-wordle-list wordle-page-url)))))
;(get-wordle-list "https://www.nytimes.com/games/wordle/index.html")

(define (get-latest-wordle-list wordle-page-url)
  (~> wordle-page-url
      wordle-page-url->wordle-js-sources
      first
      url->page-string
      page-string->wordle-list))

(define (wordle-page-url->wordle-js-sources url-of-page)
  (~> url-of-page
      url->html-xexp
      get-js-source-attributes
      attributes->js-sources
      urls->wordle-url))

;(wordle-page-url->wordle-js-sources "https://www.nytimes.com/games/wordle/index.html")

(define (url->page-string url-of-page)
  (~> url-of-page
      string->url
      get-pure-port
      port->string))

(define (page-string->wordle-list page-string)
  ;; TODO
  ;; aahed is the start of the other word list (all possible words?). This
  ;; function should be largely duplicated (and DRY'd) and return the possible
  ;; words
  (let ([raw-js-array (regexp-match #rx"=\\[(\\\"cigar\\\".*?)\\]" page-string)])
    (cond [(not raw-js-array) '()]
          [else (~> (second raw-js-array)
                    (string-replace _ "\"" "")
                    (string-split _ ",")
                    (cons "BW - before wordle (for indexing)" _))])))

;;;; wordle-page-url->wordle-js-sources support functions

(define (url->html-xexp url)
  (~> url
      string->url
      get-pure-port
      html->xexp))

(define (get-js-source-attributes html-xexp)
  (filter has-js-sources
          (parents->children '(*TOP* html body) html-xexp)))

(define (parents->children lineage-path parents)
  (cond [(null? lineage-path)         parents]
        [(null? parents)              '()]
        [(eq? (car lineage-path)
              (car parents))          (parents->children (cdr lineage-path)
                                                         (cdr parents))]
        [(and (list? (car parents))
              (eq? (car lineage-path)
                   (caar parents)))   (parents->children (cdr  lineage-path)
                                                         (cdar parents))]
        [else (parents->children lineage-path (cdr parents))]))

(define (has-js-sources child)
  (let* ([tag        (car child)]
         [attributes (member '@   (cadr child))]
         [has-source (and attributes
                          (not (null? (filter (lambda (attribute) (eq? 'src (car attribute))) (cdr attributes)))))])
    (and (eq? tag 'script)
         attributes
         has-source)))

(define (attributes->js-sources source-attributes)
  (map (lambda (source) (second (third source)))
       (filter (lambda (attribute)
                 (member 'src (map first attribute)))
               (map cdadr source-attributes))))

(define (urls->wordle-url urls)
  (filter (lambda (url)
            (string-contains? url "wordle"))
          urls))
