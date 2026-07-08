local cp = {
	bg = "#F2F0E5", -- background main window
	bg_trans = "rgba(242, 240, 229, 0.96)",
	fg = "#1A1A1A", -- cursor, text
	bg_dim = "#FFFFFF", -- inactive ui
	cursorline = "#DFDBC3", -- highlighted
	selection = "#ded7ac", -- selection
	float = "#EBE8D5", -- focusfloat

	comment = "#666359", -- comments
	punct = "#1A1A1A", -- punctuation
	accent = "#2D4F67", -- Greenish accent
	transparent = "#F2F0E5",

	keyword = "#8C2F32", -- Keyword, Return
	number = "#8C618C", -- Numbers, Booleans
	bool = "#8C618C", -- boolean
	identifier = "#1A1A1A", -- identifiers
	bi_var = "#1A1A1A",

	module = "#4D7A4D", -- Modules, Namespaces
	operator = "#B37720", -- Operators, Storage Class
	special = "#94631A", -- Special, Debug, Type definitions

	strings = "#3E613E", -- Strings
	char = "#4D7A4D", -- Regex, Special Characters

	func = "#3B6685", -- Functions
	bi_func = "#2A6B62", -- [UNUSED now, but kept for safety]
	preproc = "#368C80", -- Constants, Preprocessors

	conditional = "#6B4A6B", -- Conditionals, Repeats

	constant = "#000000", -- Constants
	param = "#1A1A1A", -- Parameters
	field = "#727f89", --  Fields
	bi_type = "#94631A",
	type = "#94631A", --  Fields
	struct = "#94631A",

	error = "#B33D41", -- Errors, Escapes
	warning = "#B37720", -- Warnings, Todo Background
	info = "#3B6685", -- Builtins, Info
	hint = "#368C80", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
