#lang racket

; https://stackoverflow.com/questions/14016254/how-do-i-read-a-web-page-in-racket

(require (planet neil/html-parsing:2:0) ; html->xexp maybe?
         net/url     ; ?
         threading   ; ~> and ~>>
         racket/port); port->string

#;(html->xexp
 (get-pure-port (string->url "https://www.nytimes.com/games/wordle/index.html")))

(define (has-js-sources child)
  (let* ([tag        (car child)]
         [attributes (member '@   (cadr child))]
         [has-source (and attributes
                          (not (null? (filter (lambda (attribute) (eq? 'src (car attribute))) (cdr attributes)))))])
    (and (eq? tag 'script)
         attributes
         has-source)))

(define (get-js-source-attributes html-xexp)
  (filter has-js-sources
        (rest (fourth (third (cdr html-xexp))))))

(define (get-js-sources-from-attributes source-attributes)
  (map (lambda (source) (second (third source)))
       (filter (lambda (attribute)
                        (member 'src (map first attribute)))
                      (map cdadr source-attributes))))

(define (get-wordle-url-from-urls urls)
  (filter (lambda (url)
            (string-contains? url "wordle"))
          urls))

#;(get-wordle-url-from-urls (get-js-sources-from-attributes (get-js-source-attributes (html->xexp
                                   (get-pure-port
                                    (string->url "https://www.nytimes.com/games/wordle/index.html"))))))

(define (get-html-xexp-from-url url)
  (~> url
      string->url
      get-pure-port
      html->xexp))

(define (get-wordle-js-source-from-wordle-page url-of-page)
  (~> url-of-page
      get-html-xexp-from-url
      get-js-source-attributes
      get-js-sources-from-attributes
      get-wordle-url-from-urls))

(define (get-page-string url-of-page)
  (~> url-of-page
      string->url
      get-pure-port
      port->string))

(define (parse-into-wordle-list page-string)
  (let ([raw-js-array (regexp-match #rx"=\\[(\\\"cigar\\\".*?)\\]" page-string)])
    (cond [(not raw-js-array) '()]
          [else (~> (second raw-js-array)
                    (string-replace _ "\"" "")
                    (string-split _ ","))])))

;(parse-into-wordle-list (get-page-string (first (get-wordle-js-source-from-wordle-page "https://www.nytimes.com/games/wordle/index.html"))))

#;(define practice-string
  ".concat(A),he=[\"cigar\",\"rebut\",\"sissy\",\"humph\",\"awake\",\"blush\",\"focal\",\"evade\",\"naval\",\"serve\",\"heath\",\"dwarf\",\"model\",\"karma\",\"stink\",\"grade\",\"quiet\",\"bench\",\"abate\",\"feign\",\"major\",\"death\",\"fresh\",\"crust\",\"stool\",\"colon\",\"abase\",\"marry\",\"react\"];other=[not, good, for output];etc")

;(parse-into-wordle-list practice-string)

#;(define (go-deep parent)
  (cond [(null? parent) '()]
        []))

; https://docs.racket-lang.org/reference/port-lib.html?q=port-%3Estring#(def._%28%28lib._racket/port..rkt%29._port-~3estring%29%29

#;(port->string
 (get-pure-port (string->url "https://www.nytimes.com/games/wordle/index.html")))

#;(port->string
 (get-pure-port (string->url "https://www.nytimes.com/games/wordle/main.5d21d0d0.js")))

#;(html->xexp
 (get-pure-port (string->url "https://www.nytimes.com/games/wordle/main.5d21d0d0.js")))

#;(regexp-match "src=\"(.*wordle\\..*\\.js)\""
                (port->string (get-pure-port (string->url "https://www.nytimes.com/games/wordle/index.html"))))
