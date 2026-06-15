local cp = {
	-- UI & BASE (UNCHANGED)
	bg = "#242422", -- background main window
	bg_trans = "rgba(36, 36, 34, 0.96)",
	fg = "#EDEDDA", -- cursor, text
	bg_dim = "#302e2c", -- inactive ui
	cursorline = "#383836", -- highlighted
	selection = "#446063", -- selection
	float = "#4e4e4a", -- focusfloat

	-- TEXT ACCENTS
	comment = "#5E5E5A", -- comments (Kept muted for contrast)
	punct = "#CCCCC0", -- punctuation (Kept neutral)
	accent = "#8ce655", -- BOLDER Greenish accent (Selected text)
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "#f00000", -- Keyword, Return (REQUESTED)
	error_red = "#ff3333", -- Errors, Escapes (Slightly lighter for readability)
	pink = "#ff5588", -- Numbers, Booleans (Vivid Raspberry)
	maroon = "#cc0000", -- Exception, Delete (Deep Red)

	-- Oranges & Yellows
	orange = "#ff9900", -- Modules, Namespaces (Pure Orange)
	coral = "#ff6644", -- Operators, Storage Class (Vibrant Coral)
	warning = "#ffcc00", -- Warnings, Todo Background (Signal Yellow)
	gold = "#ffbb33", -- Special, Debug, Type definitions (Goldenrod)

	-- Greens
	green = "#66cc55", -- Strings (Vivid Grass Green)
	lime = "#bfee40", -- Regex, Special Characters (Electric Lime)

	-- Blues & Teals
	teal = "#44cccc", -- Functions (Bright Cyan-Teal)
	cyan = "#55ddff", -- Builtins, Info (Electric Sky Blue)
	blue = "#5da0ee", -- [UNUSED] (Vibrant Blue)
	indigo = "#5588ff", -- Constants, Preprocessors (Royal Blue)

	-- Purples
	purple = "#d560e0", -- Conditionals, Repeats (Vivid Orchid)
	lavender = "#c0caff", -- [UNUSED]

	-- Neutrals / Data Family (Slightly cleaner to match bold accents)
	beige = "#f5e0a0", -- Constants (Cream)
	stone = "#C8C6BD", -- Parameters (Greige - Unchanged)
	wheat = "#e6c580", -- Fields (Rich Tan)
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
