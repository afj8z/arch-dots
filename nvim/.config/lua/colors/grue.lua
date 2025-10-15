local palette = {
	-- Core UI
	background        = "#141415", -- from bg
	foreground        = "#cdcdcd", -- from fg
	ui_black          = "#1c1c24", -- from inactiveBg
	ui_white          = "#cdcdcd", -- closest available light (fg)

	-- Syntax base
	keyword           = "#6e94b2",
	string            = "#e8b589",
	number            = "#e0a363",
	function_name     = "#c48282", -- from func
	type              = "#9bb4bc",
	variable          = "#cdcdcd", -- use fg for generic vars
	property          = "#c3c3d5",
	constant          = "#aeaed1",
	builtin           = "#b4d4cf",
	attribute         = "#bb9dbd", -- from parameter
	identifier        = "#cdcdcd", -- use fg
	comment           = "#606079",

	-- Diagnostics / emphasis
	error             = "#d8647e",
	success           = "#7fa563", -- from plus
	warning           = "#f3be7c",
	info              = "#90a0b5", -- from operator
	hint              = "#7e98e8",
	accent            = "#878787", -- from floatBorder
	highlight         = "#aeaed1", -- soft standout

	-- Secondary hues
	keyword_secondary = "#90a0b5", -- operator-ish secondary
	type_secondary    = "#aeaed1", -- gentle alt for type

	-- UI / surfaces
	menu_bg           = "#1c1c24", -- inactiveBg
	selection_bg      = "#405065", -- from search
	visual_bg         = "#525D66", -- from visual
	gutter_fg         = "#878787", -- from floatBorder
	nontext_fg        = "#606079", -- comment-toned

	-- Dim / background tints (best-fit from provided colors)
	bg_dim_black      = "#1c1c24", -- inactiveBg
	bg_dim_blue       = "#90a0b5", -- operator
	bg_dim_red        = "#d8647e", -- error
	bg_dim_yellow     = "#f3be7c", -- warning

	-- Accent / extra
	neon_accent       = "#7e98e8", -- bright cool accent (hint)
}

return palette
