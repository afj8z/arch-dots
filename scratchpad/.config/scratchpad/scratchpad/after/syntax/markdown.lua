-- This file is automatically sourced *after* the default markdown syntax file,
-- ensuring that our custom rules take precedence.

-- Link our custom groups to standard, theme-aware highlight groups.
vim.cmd("highlight link MarkdownH1 Title")
vim.cmd("highlight link MarkdownH2 Title")
vim.cmd("highlight link MarkdownH3 Identifier")
vim.cmd("highlight link MarkdownTodo Todo")
vim.cmd("highlight link MarkdownDone String")
vim.cmd("highlight link MarkdownSpecialWord Error")

-- Define the syntax rules for headings.
vim.cmd("syntax match MarkdownH1 /^# .*$/")
vim.cmd("syntax match MarkdownH2 /^## .*$/")
vim.cmd("syntax match MarkdownH3 /^### .*$/")

-- Define a match for the test word.
vim.cmd("syntax keyword MarkdownSpecialWord SPECIALWORD")

-- === Task List Highlighting ===
-- This creates a new, high-priority syntax region for the entire task list line.

-- 1. Define the parts that will be *contained* within our task list line.
vim.cmd([[syntax match MarkdownTodo "\[ \]" contained]])
vim.cmd([[syntax match MarkdownDone "\[[xX]\]" contained]])
vim.cmd([[syntax match MarkdownMarkerConceal "^\s*[-*+]\s\+" contained conceal]])

-- 2. Define the entire line as a 'region' which contains the parts above.
vim.cmd(
	[[syntax region markdownTaskLine start="^\s*[-*+]\s\+\[" end="$" keepend contains=MarkdownMarkerConceal,MarkdownTodo,MarkdownDone]]
)

-- 3. Give our new region top priority by adding it to the 'markdownTop' cluster.
--    This cluster is defined by the default markdown syntax file. Since this
--    'after' script runs last, our addition is guaranteed to work.
vim.cmd([[syntax cluster markdownTop add=markdownTaskLine]])
