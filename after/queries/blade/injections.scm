((php) @injection.content
    (#set! injection.language "php")
    (#set! injection.combined))
((php_only) @injection.content
    (#set! injection.combined)
    (#set! injection.language php_only))

; directive parameters
((parameter) @injection.content
    (#set! injection.language php_only))
