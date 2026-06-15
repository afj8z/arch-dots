local cp = {
	-- UI & BASE
	bg = "#242121", -- background main window
	bg_trans = "rgba(36, 33, 33, 0.96)",
	fg = "#D6C9C2", -- cursor, text
	bg_dim = "#1A1818", -- inactive ui
	cursorline = "#3B3636", -- highlighted
	selection = "#533f3f", -- selection
	float = "#4D4646", -- focusfloat
	-- TEXT ACCENTS
	comment = "#5E5656", -- comments
	punct = "#D6C9C2", -- punctuation
	accent = "#D48D6A", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#B36D6D", -- Keyword, Return
	error_red = "#B36D6D", -- Errors, Escapes
	pink = "#B8A2B3", -- Numbers, Booleans
	maroon = "#C48585", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#A9B99A", -- Modules, Namespaces
	coral = "#E1B992", -- Operators, Storage Class
	warning = "#D4A373", -- Warnings, Todo Background
	gold = "#D4A373", -- Special, Debug, Type definitions

	-- Greens
	green = "#92A67D", -- Strings
	lime = "#A9B99A", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#92A7B5", -- Functions
	cyan = "#7B92A2", -- Builtins, Info
	blue = "#7B92A2", -- [UNUSED now, but kept for safety]
	indigo = "#A2B8B5", -- Constants, Preprocessors

	-- Purples
	purple = "#A68A9F", -- Conditionals, Repeats
	lavender = "#A2B8B5", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E5DCD6", -- Constants
	stone = "#D6C9C2", -- Parameters
	wheat = "#ba7451", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
