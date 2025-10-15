local settings = {
	theme = "ever",
	border = "solid",
	symbols = {
		error = "E",
		warn = "W",
		info = "I",
		hint = "H",
	},
}

require("utils").set_settings(settings)

require("config")
require("lsp")
require("extra")
require("plugins")
require("statusline")
require("colors")

-- vim.cmd.colorscheme("monokai-pro-classic")
