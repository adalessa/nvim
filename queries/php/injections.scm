;; extends
(function_call_expression
    (
        (name) @_function (#eq? @_function "json_decode")
        (arguments (argument (string (string_value) @json )))
    )
)

(function_call_expression
    (
        (name) @_function (#eq? @_function "render")
        (arguments (argument (nowdoc (nowdoc_body) @html )))
    )
)
