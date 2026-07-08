local cp = {
	bg = "{{ background | shade.01 }}", -- background main window
	bg_trans = "{{ background | shade.01 @rgb @transparent(0.96) }}",
	fg = "{{ foreground | shade.07 }}", -- cursor, text
	bg_dim = "{{ shade.00 }}", -- inactive ui
	cursorline = "{{ shade.03 }}", -- highlighted
	selection = "{{ background @lighten(0.15) @saturate(0.1) }}", -- selection
	float = "{{  shade.02 }}", -- focusfloat

	comment = "{{ syntax.comment | shade.05 | color8 }}", -- comments
	punct = "{{ syntax.punctuation | color7 }}", -- punctuation
	accent = "{{ accent }}", -- Greenish accent
	transparent = "{{ background | shade.01 }}",

	keyword = "{{ red }}", -- Keyword, Return
	number = "{{ syntax.number | color13 | named.pink }}", -- Numbers, Booleans
	bool = "{{ color13 }}", -- boolean
	identifier = "{{ syntax.identifier | shade.07 }}", -- identifiers
	bi_var = "{{ foreground }}",

	module = "{{ orange }}", -- Modules, Namespaces
	operator = "{{ syntax.operator | color11 }}", -- Operators, Storage Class
	special = "{{ syntax.special | color3 }}", -- Special, Debug, Type definitions

	strings = "{{ green }}", -- Strings
	char = "{{ syntax.char | color10 }}", -- Regex, Special Characters

	func = "{{ syntax.function | color4 }}", -- Functions
	bi_func = "{{ syntax.builtin_function | color12 }}", -- [UNUSED now, but kept for safety]
	preproc = "{{ syntax.preprocessor | syntax.builtin_constant | color4 }}", -- Constants, Preprocessors

	conditional = "{{ syntax.conditional | color5 }}", -- Conditionals, Repeats

	constant = "{{ syntax.constant | color15 }}", -- Constants
	param = "{{ syntax.parameter | color7 }}", -- Parameters
	field = "{{ syntax.field | color12 }}", --  Fields
	bi_type = "{{ syntax.builtin_type | syntax.type | color12 }}",
	type = "{{ syntax.type | color12 }}", --  Fields
	struct = "{{ syntax.class | color3 }}",

	error = "{{ color9 }}", -- Errors, Escapes
	warning = "{{ diagnostic.warning | color3 }}", -- Warnings, Todo Background
	info = "{{ diagnostic.info | color6 }}", -- Builtins, Info
	hint = "{{ diagnostic.hint | accent  }}", -- [UNUSED now, kept for safety]

	dim_green = "#3F4F34",
	dim_red = "#452727",
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
