;; extends
; ; This file handles highlighting for standard markdown elements using Tree-sitter.
;
; ; === Headings ===
; ; Target the specific marker nodes to conceal them, and the inline text to highlight it.
(atx_h1_marker) @conceal (#set! conceal "")
;
; (atx_heading
;   (atx_h2_marker) @conceal
;   (inline) @MarkdownH2
;   (#set! conceal ""))
;
; (atx_heading
;   (atx_h3_marker) @conceal
;   (inline) @MarkdownH3
;   (#set! conceal ""))
;
; ; === Standard GFM Task Lists (Sub-tasks) ===
; ; This highlights tasks that start with "-", "*", or "+".
;
; ; First, conceal the list marker itself (e.g., the "-").
[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
] @conceal (#set! conceal "")
;
; Now, highlight and conceal the checkbox part using the correct, specific nodes.
((task_list_marker_unchecked) @conceal (#set! conceal ""))
((task_list_marker_checked) @conceal (#set! conceal ""))
((fenced_code_block_delimiter) @conceal (#set! conceal ""))

((list_marker_minus) @conceal (#set! conceal ""))

((list_marker_minus) @punctuation.special.list_minus.conceal (#set! conceal "•"))

