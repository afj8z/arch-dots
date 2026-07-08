-- Color scheme matching updated Palette
config.colors = {
	foreground = "{{ foreground || shade.07 }}",
	background = "{{ background | shade.01 }}",
	cursor_bg = "{{ foreground || shade.07 }}",
	cursor_fg = "{{ background | shade.01 }}",
	selection_fg = "{{ foreground || shade.07 }}",
	selection_bg = "{{ background @lighten(0.15) @saturate(0.1) }}", -- selection

	ansi = {
		"{{ shade.03 }}", -- black (cursorline)
		"{{ color1 }}", -- red (keyword)
		"{{ color2 }}", -- green (string)
		"{{ color3 }}", -- yellow (warning)
		"{{ color4 }}", -- blue (blue)
		"{{ color5 }}", -- magenta (purple)
		"{{ color6 }}", -- cyan (cyan)
		"{{ syntax.constant | color15 }}", -- white (beige)
	},
	brights = {
		"{{ color8 }}", -- bright black (comment)
		"{{ color9 }}", -- bright red (error_red)
		"{{ color10 }}", -- bright green (lime)
		"{{ syntax.special | color3 }}", -- bright yellow (gold)
		"{{ color12 }}", -- bright blue (teal)
		"{{ color14 }}", -- bright magenta (lavender)
		"#89B4FA", -- bright cyan (indigo)
		"{{ foreground || shade.07 }}", -- bright white (fg)
	},
}
