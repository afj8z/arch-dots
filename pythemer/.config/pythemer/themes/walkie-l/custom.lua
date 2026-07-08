local cp = {
	bg = "#f2f0f1", -- background main window
	bg_trans = "rgba(242, 240, 241, 0.96)",
	fg = "#242324", -- cursor, text
	bg_dim = "#f2f0f1", -- inactive ui
	cursorline = "#a8a6a7", -- highlighted
	selection = "#d3c2cc", -- selection
	float = "#c7c5c6", -- focusfloat

	comment = "#7d7b7c", -- comments
	punct = "#7d7b7c", -- punctuation
	accent = "#9a7895", -- Greenish accent
	transparent = "#f2f0f1",

	keyword = "#9a7895", -- Keyword, Return
	number = "#b5533c", -- Numbers, Booleans
	bool = "#a65986", -- boolean
	identifier = "#242324", -- identifiers
	bi_var = "#242324",

	module = "#4d7991", -- Modules, Namespaces
	operator = "#5b9191", -- Operators, Storage Class
	special = "#a65986", -- Special, Debug, Type definitions

	strings = "#6a947c", -- Strings
	char = "#b8a24d", -- Regex, Special Characters

	func = "#6074a8", -- Functions
	bi_func = "#6074a8", -- [UNUSED now, but kept for safety]
	preproc = "#b85c63", -- Constants, Preprocessors

	conditional = "#9a7895", -- Conditionals, Repeats

	constant = "#b5533c", -- Constants
	param = "#b5533c", -- Parameters
	field = "#242324", --  Fields
	bi_type = "#a65986",
	type = "#c48c3b", --  Fields
	struct = "#c48c3b",

	error = "#b85c63", -- Errors, Escapes
	warning = "#b8a24d", -- Warnings, Todo Background
	info = "#4894b5", -- Builtins, Info
	hint = "#a65986", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
