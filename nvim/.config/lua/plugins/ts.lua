vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.filetype.add({
	extension = { kbd = "kbd" },
})
vim.treesitter.language.register('kanata', 'kbd')

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"svelte",
		"typescript",
		"javascript",
		"bash",
		"css",
		"html",
		"json",
		"lua",
		"markdown",
		"tsx",
		"vim",
		"vimdoc",
		"luadoc",
		"python",
		"yaml",
		"starlark"
	},
	highlight = { enable = true },
	autopairs = {
		enable = true,
	},
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.kanata = {
	install_info = {
		url = "~/.config/nvim/nvim-ts/tree-sitter-kanata", -- local path or git repo
		files = { "src/parser.c" },                      -- note that some parsers also require src/scanner.c or src/scanner.cc
	},
	filetype = "kbd",                                  -- if filetype does not match the parser name
}

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
})
