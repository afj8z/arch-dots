vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" }
})

require("vague").setup({
	transparent = true, -- don't set background
	-- disable bold/italic globally in `style`
	bold = true,
	italic = true,
	style = {
		-- "none" is the same thing as default. But "italic" and "bold" are also valid options
		boolean = "bold",
		number = "none",
		float = "none",
		error = "bold",
		comments = "italic",
		conditionals = "none",
		functions = "none",
		headings = "bold",
		operators = "none",
		strings = "italic",
		variables = "none",

		-- keywords
		keywords = "none",
		keyword_return = "italic",
		keywords_loop = "none",
		keywords_label = "none",
		keywords_exception = "none",

		-- builtin
		builtin_constants = "bold",
		builtin_functions = "none",
		builtin_types = "bold",
		builtin_variables = "none",
	},
	-- plugin styles where applicable
	-- make an issue/pr if you'd like to see more styling options!
	plugins = {
		cmp = {
			match = "bold",
			match_fuzzy = "bold",
		},
		dashboard = {
			footer = "italic",
		},
		lsp = {
			diagnostic_error = "bold",
			diagnostic_hint = "none",
			diagnostic_info = "italic",
			diagnostic_ok = "none",
			diagnostic_warn = "bold",
		},
		neotest = {
			focused = "bold",
			adapter_name = "bold",
		},
		telescope = {
			match = "bold",
		},
	},
	-- Override highlights or add new highlights
	on_highlights = function(highlights, colors)
		-- Directly add or change keys on the 'highlights' table
		highlights.StatuslineModeNormal = { fg = colors.fg, bg = colors.func, style = { "bold" } }
		highlights.StatuslineModePending = { fg = colors.fg, bg = colors.builtin, style = { "bold" } }
		highlights.StatuslineModeVisual = { fg = colors.fg, bg = colors.visual, style = { "bold" } }
		highlights.StatuslineModeInsert = { fg = colors.bg, bg = colors.fg, style = { "bold" } }
		highlights.StatuslineModeCommand = { fg = colors.fg, bg = colors.constant, style = { "bold" } }
		highlights.StatuslineModeOther = { fg = colors.bg, bg = colors.parameter, style = { "bold" } }
		highlights.YankHighlight = { fg = colors.bg, bg = colors.string, style = { "bold" } }
		highlights.BracketRegion = { bg = colors.inactiveBg } -- Changed to a visible color for example

		-- You do not need to return anything
	end,

	-- Override colors
	colors = require("plugins.share.ever")

})

vim.cmd("colorscheme vague")
