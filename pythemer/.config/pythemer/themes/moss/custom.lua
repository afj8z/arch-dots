local cp = {
	-- UI & BASE
	bg = "#242826", -- background main window
	bg_trans = "rgba(36, 40, 38, 0.96)",
	fg = "#D4D9C7", -- cursor, text
	bg_dim = "#1A1D1C", -- inactive ui
	cursorline = "#383E3B", -- highlighted
	selection = "#40584c", -- selection
	float = "#454C49", -- focusfloat
	-- TEXT ACCENTS
	comment = "#5A635F", -- comments
	punct = "#D4D9C7", -- punctuation
	accent = "#8DA38D", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#B88D8D", -- Keyword, Return
	error_red = "#B88D8D", -- Errors, Escapes
	pink = "#C5A7C9", -- Numbers, Booleans
	maroon = "#C9A7A7", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#AFC9A7", -- Modules, Namespaces
	coral = "#C9C3A7", -- Operators, Storage Class
	warning = "#B8B08D", -- Warnings, Todo Background
	gold = "#B8B08D", -- Special, Debug, Type definitions

	-- Greens
	green = "#97B88D", -- Strings
	lime = "#AFC9A7", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#A7B1C9", -- Functions
	cyan = "#8D9AB8", -- Builtins, Info
	blue = "#8D9AB8", -- [UNUSED now, but kept for safety]
	indigo = "#A7C9C4", -- Constants, Preprocessors

	-- Purples
	purple = "#B38DB8", -- Conditionals, Repeats
	lavender = "#A7C9C4", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E4E8DB", -- Constants
	stone = "#D4D9C7", -- Parameters
	wheat = "#738a73", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
