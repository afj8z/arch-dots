local cp = {
	-- UI & BASE
	bg = "#1A0F12", -- background main window
	bg_trans = "rgba(36, 36, 34, 0.96)",
	fg = "#EDEDDA", -- cursor, text
	bg_dim = "#302e2c", -- inactive ui
	cursorline = "#383836", -- highlighted
	selection = "#446063", -- selection
	float = "#4e4e4a", -- focusfloat

	-- TEXT ACCENTS
	comment = "#5E5E5A", -- comments
	punct = "#CCCCC0", -- punctuation
	accent = "#98c379", -- Greenish accent (Selected text)
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#BF616A", -- Keyword, Return
	error_red = "#e06c75", -- Errors, Escapes
	pink = "#D18498", -- Numbers, Booleans
	maroon = "#C75C6A", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "#d19a66", -- Modules, Namespaces
	coral = "#D08770", -- Operators, Storage Class
	warning = "#EBCB8B", -- Warnings, Todo Background
	gold = "#E5C07B", -- Special, Debug, Type definitions

	-- Greens
	green = "#A3BE8C", -- Strings
	lime = "#B5C985", -- Regex, Special Characters

	-- Blues & Teals
	teal = "#83A4A6", -- Functions
	cyan = "#88C0D0", -- Builtins, Info
	blue = "#81A1C1", -- [UNUSED now, but kept for safety]
	indigo = "#5E81AC", -- Constants, Preprocessors (Deep Blue)

	-- Purples
	purple = "#B48EAD", -- Conditionals, Repeats
	lavender = "#B9C0E5", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "#ebdbb2", -- Constants
	stone = "#C8C6BD", -- [NEW] Parameters (Greige)
	wheat = "#DBC7A6", -- [NEW] Fields (Golden Tan)
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
