local cp = {
	bg = "#0d0b0c", -- background main window
	bg_trans = "rgba(13, 11, 12, 0.96)",
	fg = "#f7f0e8", -- cursor, text
	bg_dim = "#0d0b0c", -- inactive ui
	cursorline = "#473d43", -- highlighted
	selection = "#3b2932", -- selection
	float = "#2b2528", -- focusfloat

	comment = "#6e616b", -- comments
	punct = "#6e616b", -- punctuation
	accent = "#d4a5ce", -- Greenish accent
	transparent = "#0d0b0c",

	keyword = "#d4a5ce", -- Keyword, Return
	number = "#ffae94", -- Numbers, Booleans
	bool = "#ecc4ff", -- boolean
	identifier = "#f7f0e8", -- identifiers
	bi_var = "#f7f0e8",

	module = "#76b4d4", -- Modules, Namespaces
	operator = "#90d6d6", -- Operators, Storage Class
	special = "#ecc4ff", -- Special, Debug, Type definitions

	strings = "#a2d4be", -- Strings
	char = "#ffd88c", -- Regex, Special Characters

	func = "#92cbed", -- Functions
	bi_func = "#92cbed", -- [UNUSED now, but kept for safety]
	preproc = "#ff949c", -- Constants, Preprocessors

	conditional = "#d4a5ce", -- Conditionals, Repeats

	constant = "#ffae94", -- Constants
	param = "#ffae94", -- Parameters
	field = "#f7f0e8", --  Fields
	bi_type = "#ecc4ff",
	type = "#ffc87e", --  Fields
	struct = "#ffc87e",

	error = "#ff949c", -- Errors, Escapes
	warning = "#ffc87e", -- Warnings, Todo Background
	info = "#76b4d4", -- Builtins, Info
	hint = "#d4a5ce", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
