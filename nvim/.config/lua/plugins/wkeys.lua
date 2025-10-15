vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim.git" },

})

require("which-key").setup({

	delay = 500,

	plugins = {
		spelling = {
			enabled = true,
			suggestions = 20,
		},
	},

	presets = {
		operators = false,
		motions = false,
		text_objects = false,
		z = false,
		g = false,
	},

	win = {
		width = 25,
		height = { min = 2, max = 8 },
		border = "none",
		padding = { 0, 1, },
		col = math.huge,
		row = -1,
		title = false,
	},
	layout = {
		width = { min = 20, max = 30 },
		spacing = 2,
	},
	expand = 2,
	icons = {
		mappings = false,
		separator = "",
	},
	--
	show_help = false,
	show_keys = false,
})
