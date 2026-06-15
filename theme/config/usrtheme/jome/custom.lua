local cp = {

	white = "#777770",
	transparent = "NONE",

	gray = {
		_1000 = "#ffffea",
		_950 = "#ffffea",
		_900 = "#EAEBDB",
		_800 = "#999957",
		_700 = "#b7b19c",
		_500 = "#888888",
		_400 = "#424242",
		_200 = "#000000",
		_50 = "#000000",
	},

	orange = {
		_500 = "#8F7634",
	},

	red = {
		_400 = "#8888C7", -- NOTE: Alias rose._200.
		_500 = "#B85C57",
		_600 = "#D0D0F7",
		_800 = "#121212",
		_900 = "#030303",
	},

	indigo = {
		_400 = "#A6DCF8", -- NOTE: Alias violet._200.
		_500 = "#2A8DC5",
		_800 = "#2a2a2a",
		_900 = "#0a0a0a",
	},

	green = {
		_500 = "#98CE8F",
		_600 = "#57864E",
		_900 = "#343B34",
	},

	sky = {
		_500 = "#B0ECED",
	},

	opal = {
		_500 = "#777770",
	},

	sand = {
		_500 = "#B7B19C",
	},
	ext = {
		_visual = "#EEEEA7",
		_hl = "#EEFEFF",
		_num = "#F2ACAA",
	},
}

-- Overwrite `cp` with any user configuration colours.
local overwrite = vim.tbl_get(vim.g.tundra_opts or {}, "overwrite", "colors") or {}
return vim.tbl_deep_extend("force", cp, overwrite)
