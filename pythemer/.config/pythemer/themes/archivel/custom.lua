local cp = {
	-- UI & BASE
	bg = "#F2F0E5", -- background main window
	bg_trans = "rgba(242, 240, 229, 0.96)",
	fg = "#1A1A1A", -- cursor, text
	bg_dim = "#FFFFFF", -- inactive ui
	cursorline = "#DFDBC3", -- highlighted
	selection = "#f6f3e7", -- selection
	float = "#B8B39A", -- focusfloat
	-- TEXT ACCENTS
	comment = "#666359", -- comments
	punct = "#1A1A1A", -- punctuation
	accent = "#2D4F67", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#8C2F32", -- Keyword, Return
	error_red = "#B33D41", -- Errors, Escapes
	pink = "#8C618C", -- Numbers, Booleans
	maroon = "#B33D41", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#4D7A4D", -- Modules, Namespaces
	coral = "#B37720", -- Operators, Storage Class
	warning = "#B37720", -- Warnings, Todo Background
	gold = "#94631A", -- Special, Debug, Type definitions

	-- Greens
	green = "#3E613E", -- Strings
	lime = "#4D7A4D", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#3B6685", -- Functions
	cyan = "#3B6685", -- Builtins, Info
	blue = "#2D4F67", -- [UNUSED now, but kept for safety]
	indigo = "#368C80", -- Constants, Preprocessors

	-- Purples
	purple = "#6B4A6B", -- Conditionals, Repeats
	lavender = "#368C80", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#000000", -- Constants
	stone = "#1A1A1A", -- Parameters
	wheat = "#23333e", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
