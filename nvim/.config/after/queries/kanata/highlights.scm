; ===== Kanata (Tree-sitter) — extended highlights (Vim-regex-free) =====

; ----- comments -----
(line_comment) @comment
(block_comment) @comment

; ----- brackets / delimiters -----
["(" ")"] @punctuation.bracket

; ----- strings & paths -----
(quoted_item) @string

((list
  .
  (unquoted_item) @keyword.control.import
    (#eq? @keyword.control.import "include")
  .
  [(quoted_item) (unquoted_item)] @string.special.path))

; ----- core forms (first atom in a list) -----
((list . (unquoted_item) @keyword)
  (#any-of? @keyword
    "platform"
    "defalias" "defaliasenvcond" "defcfg" "defchords" "defchordsv2-experimental" "deffakekeys"
    "deflayer" "deflayermap"
    "deflocalkeys-win" "deflocalkeys-winiov2" "deflocalkeys-wintercept" "deflocalkeys-linux" "deflocalkeys-macos"
    "defoverrides" "defseq" "defsrc" "deftemplate" "defvar" "defvirtualkeys"))

; ----- named declarations -----
; (deflayer <NAME> ...)
((list
  .
  ((unquoted_item) @_ (#eq? @_ "deflayer"))
  .
  (unquoted_item) @namespace))

; (deflayermap (<NAME>) ...)
((list
  .
  ((unquoted_item) @_ (#eq? @_ "deflayermap"))
  .
  (list (unquoted_item) @namespace)))

; (platform (<TARGET> ...)) -> mark targets as constants
((list
  .
  ((unquoted_item) @_ (#eq? @_ "platform"))
  .
  (list (unquoted_item) @constant.builtin)))

; ----- functions / builtins -----
; Any sub-list whose first element is a symbol: treat as builtin function.
(list (list . (unquoted_item) @function.builtin (_)))

; ----- symbols & variables -----
; Aliases like @foo
((unquoted_item) @string.special.symbol
  (#lua-match? @string.special.symbol "^@.+$"))

; Variables like $foo
((unquoted_item) @variable
  (#lua-match? @variable "^%$.+$"))

; ----- numbers & booleans -----
((unquoted_item) @number
  (#lua-match? @number "^[-+]?%d+([%.]%d+)?$"))

((unquoted_item) @boolean
  (#any-of? @boolean "true" "false" "on" "off" "yes" "no"))

; ----- punctuation that are whole tokens in this grammar -----
((unquoted_item) @punctuation.delimiter
  (#any-of? @punctuation.delimiter ":" "="))
