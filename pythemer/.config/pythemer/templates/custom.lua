local cp = {
	-- UI & BASE
	bg = "{{ background | shade.01 }}", -- background main window
	bg_trans = "{{ background | shade.01 @rgb @transparent(0.96) }}",
	fg = "{{ foreground || shade.07 }}", -- cursor, text
	bg_dim = "{{ state.inactive_background | shade.00 | color0 }}", -- inactive ui
	cursorline = "{{ state.active_background | shade.03 }}", -- highlighted
	selection = "{{ state.selection_background | hl.selection_background }}", -- selection
	float = "{{ win.float_background | shade.04 }}", -- focusfloat
	-- TEXT ACCENTS
	comment = "{{ syntax.comment | shade.05 | color8 }}", -- comments
	punct = "{{ syntax.punctuation | color7 }}", -- punctuation
	accent = "{{ accent }}", -- Greenish accent
	transparent = "NONE",

	-- SYNTAX COLORS
	-- Reds & Pinks
	red = "{{ syntax.keyword | color1 | named.red }}", -- Keyword, Return
	error_red = "{{ diagnostic.error | syntax.error | color9 }}", -- Errors, Escapes
	pink = "{{ syntax.number | color13 | named.pink }}", -- Numbers, Booleans
	maroon = "{{ syntax.exception | syntax.error | diagnostic.error | color1 }}", -- Exception, Delete, Critical Tags

	-- Oranges & Yellows
	orange = "{{ syntax.module | color11 | named.orange }}", -- Modules, Namespaces
	coral = "{{ syntax.operator | color11 }}", -- Operators, Storage Class
	warning = "{{ diagnostic.warning | color3 }}", -- Warnings, Todo Background
	gold = "{{ syntax.special | color3 }}", -- Special, Debug, Type definitions

	-- Greens
	green = "{{ syntax.string | color2 | named.green }}", -- Strings
	lime = "{{ syntax.regex | syntax.char | color10 }}", -- Regex, Special Characters

	-- Blues & Teals
	teal = "{{ syntax.function | color12 }}", -- Functions
	cyan = "{{ diagnostic.info | color6 }}", -- Builtins, Info
	blue = "{{ color4 }}", -- [UNUSED now, but kept for safety]
	indigo = "{{ syntax.preprocessor | syntax.builtin_constant | color4 }}", -- Constants, Preprocessors

	-- Purples
	purple = "{{ syntax.conditional | color5 }}", -- Conditionals, Repeats
	lavender = "{{ color14 }}", -- [UNUSED now, kept for safety]

	-- Neutrals / Data Family
	beige = "{{ syntax.constant | color15 }}", -- Constants
	stone = "{{ syntax.parameter | color7 }}", -- Parameters
	wheat = "{{ syntax.field | color12 }}", --  Fields
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
