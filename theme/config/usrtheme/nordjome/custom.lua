local cp = {
	-- UI & BASE
	bg = "#1A0F12", -- background main window
	bg_trans = "rgba(26, 15, 18, 0.96)",
	fg = "#E1DFED", -- cursor, text
	bg_dim = "#170d10", -- inactive ui
	cursorline = "#35252a", -- highlighted
	selection = "#682537", -- selection
	float = "#413236", -- focusfloat

	-- TEXT ACCENTS
	comment = "#5E5659", -- comments
	punct = "#E1DFED", -- punctuation
	accent = "#5083C7", -- Greenish accent (Selected text)
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#BF616A", -- Keyword, Return
	error_red = "#BF616A", -- Errors, Escapes
	pink = "#D18498", -- Numbers, Booleans
	maroon = "#e06c75", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#B5C985", -- Modules, Namespaces
	coral = "#D08770", -- Operators, Storage Class
	warning = "#EBCB8B", -- Warnings, Todo Background
	gold = "#EBCB8B", -- Special, Debug, Type definitions

	-- Greens
	green = "#A3BE8C", -- Strings
	lime = "#B5C985", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#83A4A6", -- Functions
	cyan = "#B9C0E5", -- Builtins, Info
	blue = "#81A1C1", -- [UNUSED now, but kept for safety]
	indigo = "#B9C0E5", -- Constants, Preprocessors (Deep Blue)

	-- Purples
	purple = "#B48EAD", -- Conditionals, Repeats
	lavender = "#B9C0E5", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#D7D3EB", -- Constants
	stone = "#E1DFED", -- [NEW] Parameters (Greige)
	wheat = "#554348", -- [NEW] Fields (Golden Tan)
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
