local cp = {
	bg = "#1D1F21", -- background main window
	bg_trans = "rgba(29, 31, 33, 0.96)",
	fg = "#DEDCD3", -- cursor, text
	bg_dim = "#141617", -- inactive ui
	cursorline = "#33373B", -- highlighted
	selection = "#3a4451", -- selection
	float = "#272A2D", -- focusfloat

	comment = "#454A4F", -- comments
	punct = "#99978F", -- punctuation
	accent = "#6A779C", -- Greenish accent
	transparent = "#1D1F21",

	keyword = "#C46767", -- Keyword, Return
	number = "#C9A2C9", -- Numbers, Booleans
	bool = "#C9A2C9", -- boolean
	identifier = "#DEDCD3", -- identifiers
	bi_var = "#DEDCD3",

	module = "#AFCF9B", -- Modules, Namespaces
	operator = "#E3C78B", -- Operators, Storage Class
	special = "#C2A36B", -- Special, Debug, Type definitions

	strings = "#86A672", -- Strings
	char = "#AFCF9B", -- Regex, Special Characters

	func = "#93B5D1", -- Functions
	bi_func = "#6BA39C", -- [UNUSED now, but kept for safety]
	preproc = "#94CDC5", -- Constants, Preprocessors

	conditional = "#A375A3", -- Conditionals, Repeats

	constant = "#DEDCD3", -- Constants
	param = "#DEDCD3", -- Parameters
	field = "#454a5b", --  Fields
	bi_type = "#C2A36B",
	type = "#C2A36B", --  Fields
	struct = "#C2A36B",

	error = "#C46767", -- Errors, Escapes
	warning = "#E3C78B", -- Warnings, Todo Background
	info = "#454A4F", -- Builtins, Info
	hint = "#94CDC5", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
