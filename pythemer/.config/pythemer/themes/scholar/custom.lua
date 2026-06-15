local cp = {
	-- UI & BASE
	bg = "#16181D", -- background main window
	bg_trans = "rgba(22, 24, 29, 0.96)",
	fg = "#D7D7C8", -- cursor, text
	bg_dim = "#0D0F12", -- inactive ui
	cursorline = "#2A2F38", -- highlighted
	selection = "#31394e", -- selection
	float = "#3B424F", -- focusfloat
	-- TEXT ACCENTS
	comment = "#525866", -- comments
	punct = "#D7D7C8", -- punctuation
	accent = "#8999A8", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#C47575", -- Keyword, Return
	error_red = "#C47575", -- Errors, Escapes
	pink = "#B88CD9", -- Numbers, Booleans
	maroon = "#D98C8C", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#9EBF8C", -- Modules, Namespaces
	coral = "#D9B88C", -- Operators, Storage Class
	warning = "#D9B88C", -- Warnings, Todo Background
	gold = "#C4A375", -- Special, Debug, Type definitions

	-- Greens
	green = "#87A677", -- Strings
	lime = "#9EBF8C", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#8CA6D9", -- Functions
	cyan = "#525866", -- Builtins, Info
	blue = "#7591C4", -- [UNUSED now, but kept for safety]
	indigo = "#8CD9CD", -- Constants, Preprocessors

	-- Purples
	purple = "#A375C4", -- Conditionals, Repeats
	lavender = "#8CD9CD", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E8E8DF", -- Constants
	stone = "#D7D7C8", -- Parameters
	wheat = "#7b7f83", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
