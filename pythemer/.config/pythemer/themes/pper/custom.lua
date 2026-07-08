local cp = {
	bg = "#191724", -- background main window
	bg_trans = "rgba(25, 23, 36, 0.96)",
	fg = "#E0DEF4", -- cursor, text
	bg_dim = "#26233A", -- inactive ui
	cursorline = "#E0DEF4", -- highlighted
	selection = "#342e5a", -- selection
	float = "#908CAA", -- focusfloat

	comment = "#524F67", -- comments
	punct = "#908CAA", -- punctuation
	accent = "#907AA9", -- Greenish accent
	transparent = "#191724",

	keyword = "#907AA9", -- Keyword, Return
	number = "#D6817D", -- Numbers, Booleans
	bool = "#A590BF", -- boolean
	identifier = "#E0DEF4", -- identifiers
	bi_var = "#E0DEF4",

	module = "#286983", -- Modules, Namespaces
	operator = "#3E8FB0", -- Operators, Storage Class
	special = "#A590BF", -- Special, Debug, Type definitions

	strings = "#56949F", -- Strings
	char = "#EA9D34", -- Regex, Special Characters

	func = "#42819B", -- Functions
	bi_func = "#42819B", -- [UNUSED now, but kept for safety]
	preproc = "#B4637A", -- Constants, Preprocessors

	conditional = "#907AA9", -- Conditionals, Repeats

	constant = "#D6817D", -- Constants
	param = "#D6817D", -- Parameters
	field = "#E0DEF4", --  Fields
	bi_type = "#A590BF",
	type = "#F2B258", --  Fields
	struct = "#F2B258",

	error = "#B4637A", -- Errors, Escapes
	warning = "#EA9D34", -- Warnings, Todo Background
	info = "#286983", -- Builtins, Info
	hint = "#907AA9", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
