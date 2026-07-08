local cp = {
	bg = "#E3D6AC", -- background main window
	bg_trans = "rgba(227, 214, 172, 0.96)",
	fg = "#2b2b2b", -- cursor, text
	bg_dim = "#dcd7ba", -- inactive ui
	cursorline = "#C5B88A", -- highlighted
	selection = "#d9bf6a", -- selection
	float = "#D7C99B", -- focusfloat

	comment = "#524c44", -- comments
	punct = "#524c44", -- punctuation
	accent = "#7e9cd8", -- Greenish accent
	transparent = "#E3D6AC",

	keyword = "#B4514B", -- Keyword, Return
	number = "#A08284", -- Numbers, Booleans
	bool = "#957fb8", -- boolean
	identifier = "#2b2b2b", -- identifiers
	bi_var = "#2b2b2b",

	module = "#ffa066", -- Modules, Namespaces
	operator = "#585751", -- Operators, Storage Class
	special = "#957fb8", -- Special, Debug, Type definitions

	strings = "#76946a", -- Strings
	char = "#7B966F", -- Regex, Special Characters

	func = "#7e9cd8", -- Functions
	bi_func = "#658594", -- [UNUSED now, but kept for safety]
	preproc = "#ffa066", -- Constants, Preprocessors

	conditional = "#B4514B", -- Conditionals, Repeats

	constant = "#e46876", -- Constants
	param = "#2b2b2b", -- Parameters
	field = "#235985", --  Fields
	bi_type = "#dca561",
	type = "#dca561", --  Fields
	struct = "#ff9e3b",

	error = "#c8405a", -- Errors, Escapes
	warning = "#E4964C", -- Warnings, Todo Background
	info = "#235985", -- Builtins, Info
	hint = "#4C9A9C", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
