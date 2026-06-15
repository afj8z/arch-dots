package.loaded["nvim-tundra.palette.custom"] = nil
local cp = require("nvim-tundra.palette.custom")
local stylesheet = {}

stylesheet.cp = cp

stylesheet.fg = {
	normal = cp.fg, -- Normal (default) window foreground.
	unfocused = cp.comment, -- Dimmed text for unfocused windows
	conceal = cp.comment, -- Placeholder conceal characters
	lnumber = cp.comment, -- Line number foreground.
	statusline = cp.fg, -- Statusline text.
	whitespace = cp.cursorline, -- Whitespace characters (subtle).
	activeui_unf = cp.warning, -- Active UI element in unfocused window
	accent = cp.accent,
}

stylesheet.bg = {
	normal = cp.bg, -- Normal (default) window background.
	floating = cp.float, -- Floating window background (using main bg for blend).
	colorcolumn = cp.cursorline, -- Colorcolumn background.
	cursorline = cp.cursorline, -- Cursorline background.
	cursor = cp.fg, -- Cursor background.
	visual = cp.selection, -- Visual selection background.
	transparent = cp.transparent,
	dimmed = cp.bg_dim, -- Default background if `dim_inactive_windows` is set.
	sidebar = cp.bg, -- Sidebar background
	border = cp.float, -- Border colors
	highlight = cp.cursorline,
	black = cp.bg, -- Fallback black
	statusline = cp.cursorline, -- Statusline background
	tab = cp.selection, -- Tab background
}

stylesheet.syntax = {
	comment = cp.comment, -- Comments.
	conditional = cp.purple, -- Conditional keywords, e.g., `if`, `when`.
	constant = cp.beige, -- Constants, e.g., upper-case variables in Python.
	field = cp.wheat, -- [UPDATED] Object and struct fields.
	func = cp.teal, -- Function definitions.
	identifier = cp.fg, -- Identifiers (variable names).
	keyword = cp.red, -- Keywords.
	parameter = cp.stone, -- [UPDATED] Parameters (Treesitter specific).
	number = cp.pink, -- Numbers and floats.
	operator = cp.coral, -- Operators, e.g., `is`, `not`.
	preprocessor = cp.indigo, -- Preprocessor #if, #else, etc.
	punctuation = cp.punct, -- Any punctuation, e.g., brackets and commas.
	regex = cp.lime, -- Regular expressions.
	string = cp.green, -- Strings.
	type = cp.gold, -- Type (and class) definitions.
	variable = cp.fg, -- Variables.
	special = cp.gold, -- Special characters
	namespace = cp.orange, -- [ADDED] Namespace color (fixing the gap mentioned previously)
}

stylesheet.syntax.builtin = {
	const = cp.indigo, -- Built-in constants, e.g., `nil` in Lua.
	func = cp.cyan, -- Built-in functions, e.g., `print` in Lua.
	type = cp.cyan, -- Built-in types, e.g., `i32` in Rust.
	var = cp.coral, -- Language-defined variables, e.g., `self` in Python.
}

stylesheet.diagnostics = {
	error = cp.error_red,
	warning = cp.warning,
	information = cp.cyan,
	hint = cp.green,
	reference = cp.cursorline,
}

stylesheet.diff = {
	add = cp.green,
	change = cp.blue,
	delete = {
		fg = cp.maroon,
		bg = cp.bg,
	},
	text = cp.fg,
}

stylesheet.git = {
	added = cp.green,
	changed = cp.orange,
	removed = cp.maroon,
}

return stylesheet
