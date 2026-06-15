local cp = {
	-- UI & BASE
	bg = "#252930", -- background main window
	bg_trans = "rgba(37, 41, 48, 0.96)",
	fg = "#D1D7E0", -- cursor, text
	bg_dim = "#1B1E23", -- inactive ui
	cursorline = "#39414D", -- highlighted
	selection = "#3e4c63", -- selection
	float = "#454E5C", -- focusfloat
	-- TEXT ACCENTS
	comment = "#5B6473", -- comments
	punct = "#D1D7E0", -- punctuation
	accent = "#89A7B1", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#B88D8D", -- Keyword, Return
	error_red = "#B88D8D", -- Errors, Escapes
	pink = "#B8A7C9", -- Numbers, Booleans
	maroon = "#C9A7A7", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#A7C9B1", -- Modules, Namespaces
	coral = "#C9C3A7", -- Operators, Storage Class
	warning = "#B8B08D", -- Warnings, Todo Background
	gold = "#B8B08D", -- Special, Debug, Type definitions

	-- Greens
	green = "#8DB89A", -- Strings
	lime = "#A7C9B1", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#A7B7C9", -- Functions
	cyan = "#5B6473", -- Builtins, Info
	blue = "#8DA1B8", -- [UNUSED now, but kept for safety]
	indigo = "#A7C9C9", -- Constants, Preprocessors

	-- Purples
	purple = "#A38DB8", -- Conditionals, Repeats
	lavender = "#A7C9C9", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E6E9EF", -- Constants
	stone = "#D1D7E0", -- Parameters
	wheat = "#79898e", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
