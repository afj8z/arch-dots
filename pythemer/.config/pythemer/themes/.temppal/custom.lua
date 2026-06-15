local cp = {
	-- UI & BASE
	bg = "#16181B", -- background main window
	bg_trans = "rgba(22, 24, 27, 0.96)",
	fg = "#8B949E", -- cursor, text
	bg_dim = "#090c0f", -- inactive ui
	cursorline = "#2e3137", -- highlighted
	selection = "#354762", -- selection
	float = "#393d44", -- focusfloat

	-- TEXT ACCENTS
	comment = "#474D54", -- comments
	punct = "#7D868F", -- punctuation
	accent = "#4D6A85", -- Greenish accent (Selected text)
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#855459", -- Keyword, Return
	error_red = "#855459", -- Errors, Escapes
	pink = "#967B94", -- Numbers, Booleans
	maroon = "#996267", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#749179", -- Modules, Namespaces
	coral = "#A38E6A", -- Operators, Storage Class
	warning = "#A38E6A", -- Warnings, Todo Background
	gold = "#8F7D5D", -- Special, Debug, Type definitions

	-- Greens
	green = "#637D68", -- Strings
	lime = "#749179", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#6C88A1", -- Functions
	cyan = "#5E778C", -- Builtins, Info
	blue = "#5E778C", -- [UNUSED now, but kept for safety]
	indigo = "#6E959B", -- Constants, Preprocessors (Deep Blue)

	-- Purples
	purple = "#826A80", -- Conditionals, Repeats
	lavender = "#6E959B", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#95A0AA", -- Constants
	stone = "#8B949E", -- [NEW] Parameters (Greige)
	wheat = "#4D6A85", -- [NEW] Fields (Golden Tan)
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
