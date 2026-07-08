local cp = {
	bg = "#f4f6f0", -- background main window
	bg_trans = "rgba(244, 246, 240, 0.96)",
	fg = "#2c3328", -- cursor, text
	bg_dim = "#f4f6f0", -- inactive ui
	cursorline = "#b3bba9", -- highlighted
	selection = "#d3debb", -- selection
	float = "#d1d6cb", -- focusfloat

	comment = "#77856b", -- comments
	punct = "#77856b", -- punctuation
	accent = "#5e8b54", -- Greenish accent
	transparent = "#f4f6f0",

	keyword = "#8a5a8a", -- Keyword, Return
	number = "#c25e5e", -- Numbers, Booleans
	bool = "#a16ba1", -- boolean
	identifier = "#2c3328", -- identifiers
	bi_var = "#2c3328",

	module = "#427b9c", -- Modules, Namespaces
	operator = "#3c8b8b", -- Operators, Storage Class
	special = "#a16ba1", -- Special, Debug, Type definitions

	strings = "#5e8b54", -- Strings
	char = "#b88d3d", -- Regex, Special Characters

	func = "#5391b5", -- Functions
	bi_func = "#5391b5", -- [UNUSED now, but kept for safety]
	preproc = "#ab4a4a", -- Constants, Preprocessors

	conditional = "#8a5a8a", -- Conditionals, Repeats

	constant = "#c25e5e", -- Constants
	param = "#c25e5e", -- Parameters
	field = "#2c3328", --  Fields
	bi_type = "#a16ba1",
	type = "#a07b32", --  Fields
	struct = "#a07b32",

	error = "#ab4a4a", -- Errors, Escapes
	warning = "#a07b32", -- Warnings, Todo Background
	info = "#427b9c", -- Builtins, Info
	hint = "#8a5a8a", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
