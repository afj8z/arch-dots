vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"rust",
		"svelte",
		"rst",
		"typescript",
		"javascript",
		"bash",
		"css",
		"html",
		"json",
		"lua",
		"markdown",
		"regex",
		"markdown_inline",
		"tsx",
		"vim",
		"vimdoc",
		"luadoc",
		"python",
		"yaml",
		"kanata",
		"latex",
		"git_config",
		"hyprlang",
		"rasi",
		"c",
	},
	highlight = { enable = true },
	autopairs = {
		enable = true,
	},
})

vim.filetype.add({
	extension = { kbd = "kbd", rasi = "rasi", rofi = "rasi", wofi = "rasi" },
	filename = {
		["vifmrc"] = "vim",
	},
	pattern = {
		[".*/waybar/config"] = "jsonc",
		[".*/kitty/.+%.conf"] = "kitty",
		[".*/hypr/.+%.conf"] = "hyprlang",
		["%.env%.[%w_.-]+"] = "sh",
	},
})
vim.treesitter.language.register("kanata", "kbd")

vim.treesitter.language.register("bash", "kitty")

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.kanata = {
	install_info = {
		url = "~/.config/nvim/nvim-ts/tree-sitter-kanata", -- local path or git repo
		files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
	},
	filetype = "kbd",
}

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
})
