local cp = {
	bg = "#262124", -- background main window
	bg_trans = "rgba(38, 33, 36, 0.96)",
	fg = "#e9daca", -- cursor, text
	bg_dim = "#262124", -- inactive ui
	cursorline = "#5c515a", -- highlighted
	selection = "#563e4c", -- selection
	float = "#41383f", -- focusfloat

	comment = "#857782", -- comments
	punct = "#857782", -- punctuation
	accent = "#b599b1", -- Greenish accent
	transparent = "#262124",

	keyword = "#b599b1", -- Keyword, Return
	number = "#e59e89", -- Numbers, Booleans
	bool = "#c9acda", -- boolean
	identifier = "#e9daca", -- identifiers
	bi_var = "#e9daca",

	module = "#6592aa", -- Modules, Namespaces
	operator = "#7bb2b2", -- Operators, Storage Class
	special = "#c9acda", -- Special, Debug, Type definitions

	strings = "#8cb3a1", -- Strings
	char = "#efbe76", -- Regex, Special Characters

	func = "#7da8bf", -- Functions
	bi_func = "#7da8bf", -- [UNUSED now, but kept for safety]
	preproc = "#d3868c", -- Constants, Preprocessors

	conditional = "#b599b1", -- Conditionals, Repeats

	constant = "#e59e89", -- Constants
	param = "#e59e89", -- Parameters
	field = "#e9daca", --  Fields
	bi_type = "#c9acda",
	type = "#e2b071", --  Fields
	struct = "#e2b071",

	error = "#d3868c", -- Errors, Escapes
	warning = "#e2b071", -- Warnings, Todo Background
	info = "#6592aa", -- Builtins, Info
	hint = "#b599b1", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
