require("nvim-tundra").setup({
	syntax = {
		booleans = { bold = true, italic = false },
		conditionals = { bold = true },
		constants = { bold = true },
		operators = { bold = true },
	},
	plugins = {
		lsp = true,
		semantic_tokens = true,
		treesitter = true,
		telescope = true,
		nvimtree = true,
		cmp = true,
		dbui = true,
		gitsigns = true,
		neogit = true,
		textfsm = true,
	},
})

vim.g.tundra_biome = "autumn"
vim.cmd("colorscheme tundra")
-- require("lackluster").setup()
--
-- vim.cmd.colorscheme("lackluster")
