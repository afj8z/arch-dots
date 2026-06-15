local cp = {
	-- UI & BASE
	bg = "#282624", -- background main window
	bg_trans = "rgba(40, 38, 36, 0.96)",
	fg = "#D6D1CB", -- cursor, text
	bg_dim = "#1F1D1C", -- inactive ui
	cursorline = "#3D3A37", -- highlighted
	selection = "#584c40", -- selection
	float = "#4D4945", -- focusfloat
	-- TEXT ACCENTS
	comment = "#635F59", -- comments
	punct = "#D6D1CB", -- punctuation
	accent = "#A39E8B", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#B38585", -- Keyword, Return
	error_red = "#B38585", -- Errors, Escapes
	pink = "#B39FB3", -- Numbers, Booleans
	maroon = "#C79797", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#9FB39F", -- Modules, Namespaces
	coral = "#C7B397", -- Operators, Storage Class
	warning = "#C7B397", -- Warnings, Todo Background
	gold = "#B39E85", -- Special, Debug, Type definitions

	-- Greens
	green = "#8B9E8B", -- Strings
	lime = "#9FB39F", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#97A7C7", -- Functions
	cyan = "#8594B3", -- Builtins, Info
	blue = "#8594B3", -- [UNUSED now, but kept for safety]
	indigo = "#97C7C7", -- Constants, Preprocessors

	-- Purples
	purple = "#9E8BA3", -- Conditionals, Repeats
	lavender = "#97C7C7", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#E8E4DF", -- Constants
	stone = "#D6D1CB", -- Parameters
	wheat = "#8a8571", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
