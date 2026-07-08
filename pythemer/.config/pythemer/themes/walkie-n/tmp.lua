local cp = {
	bg = "#1e1e20", -- background main window
	bg_trans = "rgba(30, 30, 32, 0.96)",
	fg = "#dcd7ba", -- cursor, text
	bg_dim = "#161617", -- inactive ui
	cursorline = "#404044", -- highlighted
	selection = "#3c3c4e", -- selection
	float = "#2a2a2d", -- focusfloat

	comment = "#585751", -- comments
	punct = "#585751", -- punctuation
	accent = "#ff5d62", -- Greenish accent
	transparent = "#1e1e20",

	keyword = "#ff5d62", -- Keyword, Return
	number = "#d27e99", -- Numbers, Booleans
	bool = "#ff5d62", -- Exception, Delete, Critical Tags
	identifier = "#dcd7ba", -- identifiers

	module = "#ffa066", -- Modules, Namespaces
	operator = "#dcd7ba", -- Operators, Storage Class
	special = "#957fb8", -- Special, Debug, Type definitions

	strings = "#98bb6c", -- Strings
	char = "#e46876", -- Regex, Special Characters

	func = "#7e9cd8", -- Functions
	bi_func = "#658594", -- [UNUSED now, but kept for safety]
	preproc = "#ffa066", -- Constants, Preprocessors

	conditional = "#ff5d62", -- Conditionals, Repeats

	constant = "#e46876", -- Constants
	param = "#dcd7ba", -- Parameters
	field = "#7fb4ca", --  Fields
	type = "#dca561", --  Fields
	struct = "#dca561", --  Fields

	error = "#c8405a", -- Errors
	info = "#7fb4ca", -- Info
	hint = "#6a9589",
	warning = "#ffa066", -- Warnings

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
