local kanaGawa = {
	bg = "#0d0c0c",         -- darker than Kanagawa's default `#1f1f28`
	fg = "#dcd7ba",         -- main foreground (FujiWhite)

	floatBorder = "#363646", -- waveSurface
	line = "#1f1f28",       -- original Kanagawa background

	comment = "#727169",    -- SumiInk4 (grayish)
	builtin = "#957fb8",    -- OniViolet (function-ish purple)
	func = "#c48282",       -- WaveBlue (function/callable)

	string = "#98bb6c",     -- SpringGreen (string)
	number = "#ffa066",     -- SurimiOrange (number/constant)
	property = "#7aa89f",   -- DragonBlue (property/field)
	constant = "#ff9e3b",   -- CarpYellow (constant/boolean)
	parameter = "#dcd7ba",  -- FujiWhite (ident)

	visual = "#2a2a37",     -- SakuraHighlight (visual selection)

	error = "#e82424",      -- ErrorRed (error diagnostics)
	warning = "#ff9e3b",    -- CarpYellow
	hint = "#7fb4ca",       -- CrystalBlue (hint)

	operator = "#c8c093",   -- OldWhite (operators)
	keyword = "#7e9cd8",    -- OniViolet (keywords/statements)
	type = "#7aa89f",       -- DragonBlue (types)

	search = "#223249",     -- WaveBlue1 (search bg)
	plus = "#76946a",       -- AutumnGreen (added diff)
	delta = "#ffa066",      -- SurimiOrange (change/diff delta)
}

local rosePine = {
	bg = "#111016",         -- darker than the original Rosé Pine base
	fg = "#e0def4",         -- main text (foam)

	floatBorder = "#403d52", -- surface-2 (subtle border)
	line = "#1f1d2e",       -- surface-1 (line highlight)

	comment = "#6e6a86",    -- muted (gray-purple)
	builtin = "#c4a7e7",    -- iris (functions, builtins)
	func = "#c4a7e7",       -- same as builtin

	string = "#9ccfd8",     -- foam (cool pastel cyan)
	number = "#f6c177",     -- gold (warm orange)

	property = "#ebbcba",   -- love (reddish for fields)
	constant = "#f6c177",   -- gold (constants, booleans)
	parameter = "#e0def4",  -- text (standard identifiers)

	visual = "#2a273f",     -- overlay dark (visual select)

	error = "#eb6f92",      -- love (red-pink)
	warning = "#f6c177",    -- gold (amber-yellow)
	hint = "#9ccfd8",       -- foam (pastel cyan)

	operator = "#e0def4",   -- text
	keyword = "#c4a7e7",    -- iris (keywords)
	type = "#9ccfd8",       -- foam (types)

	search = "#26233a",     -- overlay (search highlight)
	plus = "#31748f",       -- pine (positive diff)
	delta = "#f6c177",      -- gold (warn / diff change)
}

local defColors = {
	bg = "#151515",
	fg = "#cdcdcd",
	floatBorder = "#878787",
	line = "#252530",
	comment = "#606079",
	builtin = "#b4d4cf",
	func = "#c48282",
	string = "#e8b589",
	number = "#e0a363",
	property = "#c3c3d5",
	constant = "#aeaed1",
	parameter = "#bb9dbd",
	visual = "#333738",
	error = "#d8647e",
	warning = "#f3be7c",
	hint = "#7e98e8",
	operator = "#90a0b5",
	keyword = "#6e94b2",
	type = "#9bb4bc",
	search = "#405065",
	plus = "#7fa563",
	delta = "#f3be7c",
}

local kanaPaperColors = {
	bg = "#1f1f28",
	fg = "#c6c6d0",
	floatBorder = "#878787",
	line = "#252530",
	comment = "#606079",
	builtin = "#b4d4cf",
	func = "#c48282",
	string = "#e8b589",
	number = "#e0a363",
	property = "#c3c3d5",
	constant = "#aeaed1",
	parameter = "#bb9dbd",
	visual = "#6C85A6",
	error = "#d8647e",
	warning = "#f3be7c",
	hint = "#7e98e8",
	operator = "#90a0b5",
	keyword = "#6e94b2",
	type = "#9bb4bc",
	search = "#405065",
	plus = "#7fa563",
	delta = "#f3be7c",
}

local nightFox = {
	bg = "#151515",         -- unchanged
	fg = "#cdcdcd",         -- unchanged

	floatBorder = "#39506d", -- pal.bg4
	line = "#29394f",       -- pal.bg3

	comment = "#738091",    -- pal.comment
	builtin = "#c94f6d",    -- pal.red.base (builtin0)
	func = "#719cd6",       -- pal.blue.bright
	string = "#81b29a",     -- pal.green.base
	number = "#f4a261",     -- pal.orange.base
	property = "#719cd6",   -- pal.blue.base (field)
	constant = "#f6b079",   -- pal.orange.bright (builtin2 / const)
	parameter = "#63cdcf",  -- pal.cyan.base (ident)

	visual = "#333738",     -- unchanged

	error = "#c94f6d",      -- pal.red.base (diag.error)
	warning = "#dbc074",    -- pal.yellow.base (diag.warn)
	hint = "#81b29a",       -- pal.green.base (diag.hint)

	operator = "#aeafb0",   -- spec.fg2
	keyword = "#9d79d6",    -- pal.magenta.base
	type = "#dbc074",       -- pal.yellow.base

	search = "#405065",     -- unchanged
	plus = "#7fa563",       -- unchanged
	delta = "#f3be7c",      -- preserved (optional: could reuse warning)
}

local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

local function rgb_to_hex(r, g, b)
	return string.format("#%02x%02x%02x", r, g, b)
end

local function rgb_to_hsl(r, g, b)
	r, g, b = r / 255, g / 255, b / 255
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, l = 0, 0, (max + min) / 2

	if max ~= min then
		local d = max - min
		s = l > 0.5 and d / (2 - max - min) or d / (max + min)
		if max == r then
			h = (g - b) / d + (g < b and 6 or 0)
		elseif max == g then
			h = (b - r) / d + 2
		else
			h = (r - g) / d + 4
		end
		h = h / 6
	end
	return h, s, l
end

local function hsl_to_rgb(h, s, l)
	local function hue2rgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end

	if s == 0 then
		return l, l, l
	end

	local q = l < 0.5 and l * (1 + s) or l + s - l * s
	local p = 2 * l - q

	return hue2rgb(p, q, h + 1 / 3), hue2rgb(p, q, h), hue2rgb(p, q, h - 1 / 3)
end

local function check_mode(palettebg)
	local r, g, b = hex_to_rgb(palettebg)
	local h, s, l = rgb_to_hsl(r, g, b)
	if l < 0.25 then
		return "dark"
	else
		return "light"
	end
end

local function adjust_color(hex, sat_factor, lum_factor)
	local r, g, b = hex_to_rgb(hex)
	local h, s, l = rgb_to_hsl(r, g, b)
	s = math.max(0, math.min(1, s * sat_factor))
	l = math.max(0, math.min(1, l * lum_factor))
	local r2, g2, b2 = hsl_to_rgb(h, s, l)
	return rgb_to_hex(r2 * 255, g2 * 255, b2 * 255)
end

local function adjust_palette(palette, sat_factor, lum_factor)
	local new = {}
	for k, v in pairs(palette) do
		new[k] = adjust_color(v, sat_factor, lum_factor)
	end
	return new
end

local function float_bg(palette, sat_factor, lum_factor)
	local bg = adjust_color(palette.bg, sat_factor, lum_factor)
	return bg
end

local function blend_color_bg(palette)
	local dc = {
		hint = palette.hint,
		warn = palette.warning,
		error = palette.error,
		info = palette.keyword,
	}
	local s, l
	if check_mode(palette.bg) == "dark" then
		s = 0.2
		l = 0.55
	else
		s = 0.6
		l = 1.2
	end

	for k, v in pairs(dc) do
		dc[k] = adjust_color(v, s, l)
	end

	return dc
end

-- set theme
local theme = kanaGawa

local mutedColors = adjust_palette(theme, 0.55, 1.1)

local floatBg = float_bg(theme, 0.4, 0.8)

local dclr = blend_color_bg(theme)

print(dclr.error, dclr.warn, dclr.hint, dclr.info)

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
})

require("vague").setup({
	transparent = false,
	on_highlights = function(highlights, colors)
		highlights.DiagnosticError = {
			fg = colors.error,
			gui = "none",
		}
		highlights.DiagnosticWarn = {
			fg = colors.warning,
			gui = "none",
		}
		highlights.DiagnosticHint = {
			fg = colors.hint,
			gui = "italic",
		}
		highlights.DiagnosticInfo = {
			fg = colors.operator,
			gui = "italic",
		}

		highlights.DiagnosticUnderlineError = {
			sp = dclr.error,
			bg = dclr.error,
			fg = colors.bg,
			gui = "undercurl",
		}
		highlights.DiagnosticUnderlineWarn = {
			sp = dclr.warn,
			bg = dclr.warn,
			fg = colors.bg,
			gui = "undercurl",
		}
		highlights.DiagnosticUnderlineHint = {
			sp = dclr.hint,
			bg = dclr.hint,
			fg = colors.bg,
			gui = "undercurl",
		}
		highlights.DiagnosticUnderlineInfo = {
			sp = dclr.info,
			bg = dclr.info,
			fg = colors.bg,
			gui = "undercurl",
		}
		highlights.WhichKeyNormal = {
			bg = floatBg,
			guibg = floatBg,
		}
		highlights.WhichKeyBorder = {
			bg = floatBg,
			fg = colors.floatBorder,
		}
	end,

	colors = mutedColors,
})

vim.cmd("colorscheme vague")

-- vim.cmd(":hi statusline guibg=NONE")
