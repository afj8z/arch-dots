local cp = {
	bg = "#111820", -- background main window
	bg_trans = "rgba(17, 24, 32, 0.96)",
	fg = "#c0c8d0", -- cursor, text
	bg_dim = "#111820", -- inactive ui
	cursorline = "#374550", -- highlighted
	selection = "#263c58", -- selection
	float = "#28333c", -- focusfloat

	comment = "#374550", -- comments
	punct = "#374550", -- punctuation
	accent = "#458588", -- Greenish accent
	transparent = "#111820",

	keyword = "#b294bb", -- Keyword, Return
	number = "#d54e53", -- Numbers, Booleans
	bool = "#c678dd", -- boolean
	identifier = "#c0c8d0", -- identifiers
	bi_var = "#c0c8d0",

	module = "#81a2be", -- Modules, Namespaces
	operator = "#8abeb7", -- Operators, Storage Class
	special = "#c678dd", -- Special, Debug, Type definitions

	strings = "#b5bd68", -- Strings
	char = "#e5c07b", -- Regex, Special Characters

	func = "#61afef", -- Functions
	bi_func = "#61afef", -- [UNUSED now, but kept for safety]
	preproc = "#cc6666", -- Constants, Preprocessors

	conditional = "#b294bb", -- Conditionals, Repeats

	constant = "#d54e53", -- Constants
	param = "#d54e53", -- Parameters
	field = "#c0c8d0", --  Fields
	bi_type = "#c678dd",
	type = "#f0c674", --  Fields
	struct = "#f0c674",

	error = "#cc6666", -- Errors, Escapes
	warning = "#f0c674", -- Warnings, Todo Background
	info = "#81a2be", -- Builtins, Info
	hint = "#b294bb", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
