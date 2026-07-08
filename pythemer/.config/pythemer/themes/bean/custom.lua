local cp = {
	bg = "#121212", -- background main window
	bg_trans = "rgba(18, 18, 18, 0.96)",
	fg = "#d5c9be", -- cursor, text
	bg_dim = "#090909", -- inactive ui
	cursorline = "#3d3d3d", -- highlighted
	selection = "#3e3232", -- selection
	float = "#191919", -- focusfloat

	comment = "#524c44", -- comments
	punct = "#524c44", -- punctuation
	accent = "#67413f", -- Greenish accent
	transparent = "#121212",

	keyword = "#5c6569", -- Keyword, Return
	number = "#453352", -- Numbers, Booleans
	bool = "#7a6d81", -- boolean
	identifier = "#d5c9be", -- identifiers
	bi_var = "#d5c9be",

	module = "#66788f", -- Modules, Namespaces
	operator = "#746b5f", -- Operators, Storage Class
	special = "#7a6d81", -- Special, Debug, Type definitions

	strings = "#47614B", -- Strings
	char = "#7a6d81", -- Regex, Special Characters

	func = "#bb8861", -- Functions
	bi_func = "#d4a27b", -- [UNUSED now, but kept for safety]
	preproc = "#5c6569", -- Constants, Preprocessors

	conditional = "#5c6569", -- Conditionals, Repeats

	constant = "#453352", -- Constants
	param = "#d5c9be", -- Parameters
	field = "#637f78", --  Fields
	bi_type = "#67413f",
	type = "#67413f", --  Fields
	struct = "#637f78",

	error = "#460f15", -- Errors, Escapes
	warning = "#852D36", -- Warnings, Todo Background
	info = "#66788f", -- Builtins, Info
	hint = "#637f78", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
