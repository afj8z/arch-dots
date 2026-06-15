local cp = {
	-- UI & BASE
	bg = "#1F2121", -- background main window
	bg_trans = "rgba(31, 33, 33, 0.96)",
	fg = "#BDBBB0", -- cursor, text
	bg_dim = "#141515", -- inactive ui
	cursorline = "#353A3A", -- highlighted
	selection = "#3d4f4f", -- selection
	float = "#474E4E", -- focusfloat
	-- TEXT ACCENTS
	comment = "#525757", -- comments
	punct = "#BDBBB0", -- punctuation
	accent = "#8A918A", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#D18282", -- Keyword, Return
	error_red = "#D18282", -- Errors, Escapes
	pink = "#C595E6", -- Numbers, Booleans
	maroon = "#E69595", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#B5E695", -- Modules, Namespaces
	coral = "#E6D395", -- Operators, Storage Class
	warning = "#D1C082", -- Warnings, Todo Background
	gold = "#D1C082", -- Special, Debug, Type definitions

	-- Greens
	green = "#A1D182", -- Strings
	lime = "#B5E695", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#95BCE6", -- Functions
	cyan = "#B382D1", -- Builtins, Info
	blue = "#82A9D1", -- [UNUSED now, but kept for safety]
	indigo = "#95E6DD", -- Constants, Preprocessors

	-- Purples
	purple = "#B382D1", -- Conditionals, Repeats
	lavender = "#95E6DD", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#DEDCD3", -- Constants
	stone = "#BDBBB0", -- Parameters
	wheat = "#707870", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
