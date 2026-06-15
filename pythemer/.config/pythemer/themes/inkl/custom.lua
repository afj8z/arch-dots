local cp = {
	-- UI & BASE
	bg = "#F2EFE2", -- background main window
	bg_trans = "rgba(242, 239, 226, 0.96)",
	fg = "#1A1A1A", -- cursor, text
	bg_dim = "#FFFFFF", -- inactive ui
	cursorline = "#DBD6BD", -- highlighted
	selection = "#f8f4e5", -- selection
	float = "#B5B095", -- focusfloat
	-- TEXT ACCENTS
	comment = "#6B685E", -- comments
	punct = "#1A1A1A", -- punctuation
	accent = "#3E5C5C", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#942D2D", -- Keyword, Return
	error_red = "#B83B3B", -- Errors, Escapes
	pink = "#944D94", -- Numbers, Booleans
	maroon = "#B83B3B", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#4A824A", -- Modules, Namespaces
	coral = "#A87921", -- Operators, Storage Class
	warning = "#A87921", -- Warnings, Todo Background
	gold = "#8F661B", -- Special, Debug, Type definitions

	-- Greens
	green = "#3D6B3D", -- Strings
	lime = "#4A824A", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#3B73A1", -- Functions
	cyan = "#2D5A82", -- Builtins, Info
	blue = "#2D5A82", -- [UNUSED now, but kept for safety]
	indigo = "#219489", -- Constants, Preprocessors

	-- Purples
	purple = "#7A3D7A", -- Conditionals, Repeats
	lavender = "#219489", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#000000", -- Constants
	stone = "#1A1A1A", -- Parameters
	wheat = "#8C8870", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
