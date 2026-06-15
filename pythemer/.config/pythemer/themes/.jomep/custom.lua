local cp = {
	-- UI & BASE
	bg = "#261A1D", -- background main window
	bg_trans = "rgba(38, 26, 29, 0.96)",
	fg = "#D1DDE3", -- cursor, text
	bg_dim = "#1b0c0e", -- inactive ui
	cursorline = "#3e3537", -- highlighted
	selection = "#743243", -- selection
	float = "#484445", -- focusfloat
	-- TEXT ACCENTS
	comment = "#7D7276", -- comments
	punct = "#D1DDE3", -- punctuation
	accent = "#5083C7", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#BF616A", -- Keyword, Return
	error_red = "#BF616A", -- Errors, Escapes
	pink = "#D18498", -- Numbers, Booleans
	maroon = "#e06c75", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#A8C2A7", -- Modules, Namespaces
	coral = "#D9A286", -- Operators, Storage Class
	warning = "#EBCB8B", -- Warnings, Todo Background
	gold = "#EBCB8B", -- Special, Debug, Type definitions

	-- Greens
	green = "#A3BE8C", -- Strings
	lime = "#A8C2A7", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#83A4A6", -- Functions
	cyan = "#B9C0E5", -- Builtins, Info
	blue = "#81A1C1", -- [UNUSED now, but kept for safety]
	indigo = "#B9C0E5", -- Constants, Preprocessors

	-- Purples
	purple = "#B48EAD", -- Conditionals, Repeats
	lavender = "#B9C0E5", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#D7D3EB", -- Constants
	stone = "#D1DDE3", -- Parameters
	wheat = "#837CA3", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
