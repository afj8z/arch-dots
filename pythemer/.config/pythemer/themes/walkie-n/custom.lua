local cp = {
	bg = "#201e20", -- background main window
	bg_trans = "rgba(32, 30, 32, 0.96)",
	fg = "#d9d4d0", -- cursor, text
	bg_dim = "#2a262a", -- inactive ui
	cursorline = "#322d32", -- highlighted
	selection = "#3f4f5b", -- selection
	float = "#322c32", -- focusfloat

	comment = "#706370", -- comments
	punct = "#c2b5a8", -- punctuation
	accent = "#b492af", -- Greenish accent
	transparent = "#201e20",

	keyword = "#d3868c", -- Keyword, Return
	number = "#e2b071", -- Numbers, Booleans
	bool = "#e2b071", -- boolean
	identifier = "#d9d4d0", -- identifiers
	bi_var = "#b4d4cf",

	module = "#d3868c", -- Modules, Namespaces
	operator = "#7bb2b2", -- Operators, Storage Class
	special = "#c783ab", -- Special, Debug, Type definitions

	strings = "#8cb3a1", -- Strings
	char = "#a1c27c", -- Regex, Special Characters

	func = "#6891ac", -- Functions
	bi_func = "#6891ac", -- [UNUSED now, but kept for safety]
	preproc = "#d3868c", -- Constants, Preprocessors

	conditional = "#d3868c", -- Conditionals, Repeats

	constant = "#aeaed1", -- Constants
	param = "#d9d4d0", -- Parameters
	field = "#aeaed1", --  Fields
	bi_type = "#b492af",
	type = "#b492af", --  Fields
	struct = "#c783ab",

	error = "#d3868c", -- Errors, Escapes
	warning = "#e2b68d", -- Warnings, Todo Background
	info = "#b4d4cf", -- Builtins, Info
	hint = "#aeaed1", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
