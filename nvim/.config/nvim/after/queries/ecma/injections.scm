; extends

; (inherited by typescript)
; Inject into /* GraphQL */`<gql>` as graphql
((comment) @_gql_comment (#eq? @_gql_comment "/* GraphQL */")

  (expression_statement
    (template_string) @graphql
    (#offset! @graphql 0 1 0 -1)))
