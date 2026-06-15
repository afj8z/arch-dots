local cp = {
	-- UI & BASE
	bg = "#232126", -- background main window
	bg_trans = "rgba(35, 33, 38, 0.96)",
	fg = "#D1CED4", -- cursor, text
	bg_dim = "#1A181C", -- inactive ui
	cursorline = "#38353D", -- highlighted
	selection = "#483e56", -- selection
	float = "#47434D", -- focusfloat
	-- TEXT ACCENTS
	comment = "#5C5861", -- comments
	punct = "#D1CED4", -- punctuation
	accent = "#9BA8C8", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#C79393", -- Keyword, Return
	error_red = "#C79393", -- Errors, Escapes
	pink = "#C9A9C9", -- Numbers, Booleans
	maroon = "#D9A9A9", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#A9C9A9", -- Modules, Namespaces
	coral = "#E6CCAA", -- Operators, Storage Class
	warning = "#D1B894", -- Warnings, Todo Background
	gold = "#D1B894", -- Special, Debug, Type definitions

	-- Greens
	green = "#94B394", -- Strings
	lime = "#A9C9A9", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#A9BDE0", -- Functions
	cyan = "#2B292E", -- Builtins, Info
	blue = "#94A9C7", -- [UNUSED now, but kept for safety]
	indigo = "#A9C9C9", -- Constants, Preprocessors

	-- Purples
	purple = "#B394B3", -- Conditionals, Repeats
	lavender = "#A9C9C9", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E2DFE6", -- Constants
	stone = "#D1CED4", -- Parameters
	wheat = "#8690aa", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
