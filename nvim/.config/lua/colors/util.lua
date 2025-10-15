local M = {}

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

function M.adjust_palette(palette, sat_factor, lum_factor)
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

function M.settheme(palette)
	vim.cmd.highlight("clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd.syntax("reset")
	end

	for group, opts in pairs(palette) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

function M.require_color(name)
	vim.g.theme_name = name
	local full_name = "colors." .. name
	return require(full_name)
end


return M
