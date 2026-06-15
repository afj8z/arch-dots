local cp = {
	-- UI & BASE
	bg = "#222526", -- background main window
	bg_trans = "rgba(34, 37, 38, 0.96)",
	fg = "#CED4D4", -- cursor, text
	bg_dim = "#191B1C", -- inactive ui
	cursorline = "#383D3F", -- highlighted
	selection = "#3f5055", -- selection
	float = "#474D50", -- focusfloat
	-- TEXT ACCENTS
	comment = "#5A6163", -- comments
	punct = "#CED4D4", -- punctuation
	accent = "#8DA3A3", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#A88A8A", -- Keyword, Return
	error_red = "#A88A8A", -- Errors, Escapes
	pink = "#AB9CB8", -- Numbers, Booleans
	maroon = "#B89C9C", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#9CB8A6", -- Modules, Namespaces
	coral = "#B8B89C", -- Operators, Storage Class
	warning = "#B8B89C", -- Warnings, Todo Background
	gold = "#A8A88A", -- Special, Debug, Type definitions

	-- Greens
	green = "#8AA894", -- Strings
	lime = "#9CB8A6", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#9CA6B8", -- Functions
	cyan = "#8A94A8", -- Builtins, Info
	blue = "#8A94A8", -- [UNUSED now, but kept for safety]
	indigo = "#9CB8B8", -- Constants, Preprocessors

	-- Purples
	purple = "#9B8AA8", -- Conditionals, Repeats
	lavender = "#9CB8B8", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E2E8E8", -- Constants
	stone = "#CED4D4", -- Parameters
	wheat = "#738a8a", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
