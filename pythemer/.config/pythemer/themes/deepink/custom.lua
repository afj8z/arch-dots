local cp = {
	-- UI & BASE
	bg = "#1D1F21", -- background main window
	bg_trans = "rgba(29, 31, 33, 0.96)",
	fg = "#DEDCD3", -- cursor, text
	bg_dim = "#141617", -- inactive ui
	cursorline = "#33373B", -- highlighted
	selection = "#3a4451", -- selection
	float = "#454A4F", -- focusfloat
	-- TEXT ACCENTS
	comment = "#454A4F", -- comments
	punct = "#99978F", -- punctuation
	accent = "#6A779C", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#C46767", -- Keyword, Return
	error_red = "#C46767", -- Errors, Escapes
	pink = "#C9A2C9", -- Numbers, Booleans
	maroon = "#E09696", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#AFCF9B", -- Modules, Namespaces
	coral = "#E3C78B", -- Operators, Storage Class
	warning = "#E3C78B", -- Warnings, Todo Background
	gold = "#C2A36B", -- Special, Debug, Type definitions

	-- Greens
	green = "#86A672", -- Strings
	lime = "#AFCF9B", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#93B5D1", -- Functions
	cyan = "#454A4F", -- Builtins, Info
	blue = "#6B8EAD", -- [UNUSED now, but kept for safety]
	indigo = "#94CDC5", -- Constants, Preprocessors

	-- Purples
	purple = "#A375A3", -- Conditionals, Repeats
	lavender = "#94CDC5", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#DEDCD3", -- Constants
	stone = "#DEDCD3", -- Parameters
	wheat = "#616572", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
