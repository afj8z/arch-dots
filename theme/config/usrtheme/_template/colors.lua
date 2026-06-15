return {
	black = "{{ background | shade.01 }}",
	bg = "{{ background | shade.01 }}",
	float = "{{ win.float_background | shade.04 }}",
	comment = "{{ color8 }}",
	fg = "{{ foreground || shade.07 }}",
	accent = "{{ win.active_border | state.active_accent | accent }}",
	diag = {
		error = "{{ diagnostic.error | color9 }}",
		hint = "{{ diagnostic.hint | color10 }}",
		info = "{{ diagnostic.info | color6 }}",
		warn = "{{ diagnostic.warn | color3 }}",
	},
}
