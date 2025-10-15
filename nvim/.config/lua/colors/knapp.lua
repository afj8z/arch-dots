local palette = {
	-- core fg/bg
	background        = "#1F1F28", -- old bg
	foreground        = "#D9D0C5", -- old fg
	ui_black          = "#0F0F15", -- old black
	ui_white          = "#D9D7D4", -- old white

	-- syntax
	keyword           = "#938AA9", -- old lilac
	string            = "#98BC99", -- old green
	number            = "#E0C48B", -- old yellow
	function_name     = "#5884A6", -- old blue
	type              = "#9CABCA", -- old lavender
	variable          = "#D9D0C5", -- old fg
	property          = "#A6A69C", -- old grey
	constant          = "#E0BC9D", -- old orange
	builtin           = "#7E9CD8", -- old bright_blue
	attribute         = "#D27E99", -- old fuchsia
	identifier        = "#D9D0C5", -- old fg
	comment           = "#736D67", -- old comment

	-- diagnostics / accents
	error             = "#FF5D62", -- old bright_red
	success           = "#98BB6C", -- old bright_green
	warning           = "#E6C384", -- old bright_yellow
	info              = "#A3D4D5", -- old bright_cyan
	hint              = "#9CABCA", -- old lavender
	accent            = "#8992A7", -- old purple
	highlight         = "#EBE7D1", -- old bright_white

	-- secondary hues
	keyword_secondary = "#8992A7", -- old purple
	type_secondary    = "#9A7372", -- old teal

	-- UI / surfaces
	menu_bg           = "#2D2D33", -- old menu
	selection_bg      = "#4B5257", -- old selection
	visual_bg         = "#35354D", -- old visual
	gutter_fg         = "#363646", -- old gutter_fg
	nontext_fg        = "#736D67", -- old comment (subtle nontext)

	-- dim/transparent backgrounds
	bg_dim_black      = "#2A2A37", -- old transparent_black
	bg_dim_blue       = "#63727A", -- old transparent_blue
	bg_dim_red        = "#6E3F44", -- old transparent_red
	bg_dim_yellow     = "#947B65", -- old transparent_yellow

	-- extra pop
	neon_accent       = "#A3D4D5", -- old neon_cyan
}

return palette
