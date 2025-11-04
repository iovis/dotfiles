;extends

; https://github.com/tree-sitter-grammars/tree-sitter-diff/blob/2520c3f934b3179bb540d23e0ef45f75304b5fed/queries/highlights.scm
; add higher priority to added/removed lines in diffs so they don't get
; overridden by other highlights

([
  (addition)
  (new_file)
] @diff.plus
  (#set! priority 200))

([
  (deletion)
  (old_file)
] @diff.minus
  (#set! priority 200))
