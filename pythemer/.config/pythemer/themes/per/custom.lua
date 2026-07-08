local cp = {
	bg = "#e9daca", -- background main window
	bg_trans = "rgba(233, 218, 202, 0.96)",
	fg = "#3d353b", -- cursor, text
	bg_dim = "#e9daca", -- inactive ui
	cursorline = "#b4a395", -- highlighted
	selection = "#dbb48c", -- selection
	float = "#cfb7a4", -- focusfloat

	comment = "#cfb7a4", -- comments
	punct = "#cfb7a4", -- punctuation
	accent = "#A3839E", -- Greenish accent
	transparent = "#e9daca",

	keyword = "#A3839E", -- Keyword, Return
	number = "#DD8B74", -- Numbers, Booleans
	bool = "#B599B1", -- boolean
	identifier = "#3d353b", -- identifiers
	bi_var = "#3d353b",

	module = "#527E93", -- Modules, Namespaces
	operator = "#6B9E9E", -- Operators, Storage Class
	special = "#B599B1", -- Special, Debug, Type definitions

	strings = "#7DA291", -- Strings
	char = "#E5AC60", -- Regex, Special Characters

	func = "#6D97AC", -- Functions
	bi_func = "#6D97AC", -- [UNUSED now, but kept for safety]
	preproc = "#C47379", -- Constants, Preprocessors

	conditional = "#A3839E", -- Conditionals, Repeats

	constant = "#DD8B74", -- Constants
	param = "#DD8B74", -- Parameters
	field = "#3d353b", --  Fields
	bi_type = "#B599B1",
	type = "#D8A05C", --  Fields
	struct = "#D8A05C",

	error = "#C47379", -- Errors, Escapes
	warning = "#D8A05C", -- Warnings, Todo Background
	info = "#527E93", -- Builtins, Info
	hint = "#A3839E", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
