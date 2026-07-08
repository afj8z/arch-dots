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
	statusline = cp.float, -- Statusline background
	tab = cp.float, -- Tab background
}

stylesheet.syntax = {
	comment = cp.comment, -- Comments.
	conditional = cp.conditional, -- Conditional keywords, e.g., `if`, `when`.
	constant = cp.constant, -- Constants, e.g., upper-case variables in Python.
	field = cp.field, -- [UPDATED] Object and struct fields.
	func = cp.func, -- Function definitions.
	identifier = cp.identifier, -- Identifiers (variable names).
	keyword = cp.keyword, -- Keywords.
	parameter = cp.param, -- [UPDATED] Parameters (Treesitter specific).
	number = cp.number, -- Numbers and floats.
	operator = cp.operator, -- Operators, e.g., `is`, `not`.
	preprocessor = cp.preproc, -- Preprocessor #if, #else, etc.
	punctuation = cp.punct, -- Any punctuation, e.g., brackets and commas.
	regex = cp.char, -- Regular expressions.
	string = cp.strings, -- Strings.
	type = cp.type, -- Type (and class) definitions.
	variable = cp.identifier, -- Variables.
	special = cp.special, -- Special characters
	namespace = cp.module, -- [ADDED] Namespace color (fixing the gap mentioned previously)
	struct = cp.struct,
}

stylesheet.syntax.builtin = {
	const = cp.constant, -- Built-in constants, e.g., `nil` in Lua.
	func = cp.bi_func, -- Built-in functions, e.g., `print` in Lua.
	type = cp.bi_type, -- Built-in types, e.g., `i32` in Rust.
	var = cp.bi_var, -- Language-defined variables, e.g., `self` in Python.
}

stylesheet.diagnostics = {
	error = cp.error,
	warning = cp.warning,
	information = cp.info,
	hint = cp.hint,
	reference = cp.cursorline,
}

stylesheet.diff = {
	add = cp.dim_green,
	change = cp.warning,
	delete = cp.dim_red,
	text = cp.fg,
}

stylesheet.git = {
	added = cp.dim_green,
	changed = cp.warning,
	removed = cp.dim_red,
}

return stylesheet
