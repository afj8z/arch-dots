local palette = {
	-- Core UI
	background        = "#1c1a1c", -- bl
	foreground        = "#D9BFC4", -- na (soft rose)
	ui_black          = "#2e2d2f", -- gl
	ui_white          = "#E0CACE", -- light neutral rose-gray

	-- Syntax base
	keyword           = "#c58ea7", -- ia (primary pink-red)
	string            = "#DEC1C6", -- muted rose (na deeper)
	number            = "#9e97d0", -- ca (lavender blue)
	function_name     = "#878fb9", -- va (soft violet-blue)
	type              = "#92A4D1", -- mid-blue between va/ca
	variable          = "#a3b8d5", -- lighter extension of va
	property          = "#856ca7", -- muted violet (ca darker)
	constant          = "#CC8DA0", -- deeper red-pink (derived from ia)
	builtin           = "#BEABD9", -- ia reused for builtins
	attribute         = "#C49DA4", -- ca variant
	identifier        = "#856370", -- neutral gray
	comment           = "#665C5F", -- from nb/gr

	-- Bright / emphasis
	error             = "#d0677b", -- bright rose-red
	success           = "#9e97d0", -- reuse lavender for “success”
	warning           = "#bd7d8a", -- dusty pink (between na/ia)
	info              = "#7e9cd8", -- bright blue (stronger va)
	hint              = "#b8b4d0", -- soft lavender highlight
	accent            = "#a75d9e", -- pink-violet accent
	highlight         = "#e3e0e5", -- bright neutral

	-- Nuanced tones
	keyword_secondary = "#6B4B57", -- softer rose (na muted)
	type_secondary    = "#D9BFC4", -- desat mid-blue

	-- UI / surfaces
	menu_bg           = "#2a3033", -- vc
	selection_bg      = "#3f3b3e", -- gr
	visual_bg         = "#4e4044", -- nb
	gutter_fg         = "#484042", -- nc
	nontext_fg        = "#503942", -- ib

	-- Transparent tints (used for subtle bg states)
	bg_dim_black      = "#2a2a2c", -- dark neutral
	bg_dim_blue       = "#4a4e63", -- muted blue-gray (from vb/vc)
	bg_dim_red        = "#6e3f4e", -- desat red-violet
	bg_dim_yellow     = "#7a5a66", -- pink-brown, keeps harmony

	-- Accent / extra
	neon_accent       = "#7e9cd8", -- bright blue pop
}

return palette
