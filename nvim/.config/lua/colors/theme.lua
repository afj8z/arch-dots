-- nvim/lua/colors/theme.lua
local M = {
	current = nil,
	opts = {
		name = nil,      -- theme name (palette module)
		sat = 1.0,       -- default = no change
		lum = 1.0,       -- default = no change
		use_adjust = true, -- when false, bypass adjust_palette entirely
	},
}

local u = require("colors.util")
local hl = require("colors.highlight")

local function load_palette(name)
	local ok, palette = pcall(require, "colors." .. name)
	if not ok then
		error(("colors/theme: unknown palette '%s'"):format(name))
	end
	return palette
end

local function apply_highlights(palette)
	local colors
	if M.opts.use_adjust then
		colors = u.adjust_palette(palette, M.opts.sat, M.opts.lum)
	else
		colors = palette
	end
	local groups = hl.sethighlights(colors)
	vim.o.termguicolors = true
	u.settheme(groups)

	vim.cmd([[
  highlight iCursor gui=reverse guifg=NONE guibg=NONE
  set guicursor=n-v-c-sm:block,i-ci-ve:block-Cursor,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor
  "highlight FloatBorder guibg=none
  "highlight FloatTitle guibg=none
  "highlight FloatFooter guibg=none
  highlight SignColumn guibg=none
  highlight Folded guibg=none
  highlight FoldColumn guibg=none
  highlight Normal guibg=none
  "highlight NormalFloat guibg=none
  "highlight NonText guibg=none
  highlight Terminal guibg=none
  ]])
end

function M.apply(name)
	-- precedence: explicit > vim.g > env > previous > "pasta"
	name = name or vim.g.theme_name or vim.env.NVIM_THEME or M.opts.name or "pasta"
	local palette = load_palette(name)
	apply_highlights(palette)

	M.current = name
	M.opts.name = name
	vim.g.theme_name = name
	vim.notify(
		("Theme: %s  (sat=%.2f, lum=%.2f, %s)"):format(
			name,
			M.opts.sat,
			M.opts.lum,
			M.opts.use_adjust and "adjust on" or "default (no adjust)"
		),
		vim.log.levels.INFO
	)
end

function M.setup(opts)
	opts = opts or {}
	if opts.name then
		M.opts.name = opts.name
	end
	if opts.sat then
		M.opts.sat = tonumber(opts.sat) or 1.0
	end
	if opts.lum then
		M.opts.lum = tonumber(opts.lum) or 1.0
	end
	if opts.use_adjust ~= nil then
		M.opts.use_adjust = not not opts.use_adjust
	end
	M.apply(opts.name)
end

function M.reload(name)
	for k in pairs(package.loaded) do
		if k:match("^colors%.") then
			package.loaded[k] = nil
		end
	end
	M.current = nil
	M.apply(name)
end

-- Helper functions

local function parse_two_numbers(arg)
	-- accepts "a,b" with optional spaces; returns a, b as numbers or nil
	local a, b = arg:match("^%s*([%+%-]?[%d%.]+)%s*,%s*([%+%-]?[%d%.]+)%s*$")
	if a and b then
		return tonumber(a), tonumber(b)
	end
	return nil, nil
end

local function is_rel(s)
	return s:sub(1, 1) == "+" or s:sub(1, 1) == "-"
end

local function clamp(x) -- optional: keep things sane if you want
	return x
end

-- :Theme NAME?  -> switch theme
vim.api.nvim_create_user_command("Theme", function(cmd)
	if cmd.args == "" then
		M.apply()
	else
		M.apply(cmd.args)
	end
end, { nargs = "?" })

-- :ThemeAdjust {desat|sat|def|<sat,lum>}
--   desat -> sat=0.50, lum=0.90
--   sat   -> sat=1.20, lum=1.05
--   def   -> bypass adjust (use palette defaults)
--   a,b   -> manual values (enable adjust)
vim.api.nvim_create_user_command("ThemeAdjust", function(cmd)
	local arg = cmd.args
	if arg == "" then
		vim.notify(
			("ThemeAdjust: current sat=%.2f lum=%.2f (%s)"):format(
				M.opts.sat,
				M.opts.lum,
				M.opts.use_adjust and "adjust on" or "default (no adjust)"
			)
		)
		return
	end

	local low = arg:lower()
	if low == "desat" then
		M.opts.sat, M.opts.lum = 0.50, 0.90
		M.opts.use_adjust = true
	elseif low == "sat" then
		M.opts.sat, M.opts.lum = 1.20, 1.05
		M.opts.use_adjust = true
	elseif low == "def" then
		M.opts.use_adjust = false
	else
		local a, b = parse_two_numbers(arg)
		if not (a and b) then
			vim.notify("ThemeAdjust: expected 'desat' | 'sat' | 'def' | '<sat>,<lum>'", vim.log.levels.ERROR)
			return
		end
		M.opts.sat, M.opts.lum = a, b
		M.opts.use_adjust = true
	end

	M.apply()
end, {
	nargs = "?",
	complete = function(_, line)
		local items = { "desat", "sat", "def" }
		local prefix = line:match("%S+$") or ""
		local out = {}
		for _, it in ipairs(items) do
			if it:find("^" .. vim.pesc(prefix)) then
				table.insert(out, it)
			end
		end
		return out
	end,
})

-- :ThemeSat +/-X | X
--   '+0.10' / '-0.05' -> relative
--   '1.10'            -> absolute
--   no arg -> show current
vim.api.nvim_create_user_command("ThemeSat", function(cmd)
	local a = cmd.args
	if a == "" then
		vim.notify(("ThemeSat: sat=%.2f"):format(M.opts.sat))
		return
	end
	local v = tonumber(a)
	if not v then
		vim.notify("ThemeSat: expected number like +0.10, -0.05, or 1.10", vim.log.levels.ERROR)
		return
	end
	if is_rel(a) then
		M.opts.sat = clamp(M.opts.sat + v)
	else
		M.opts.sat = clamp(v)
	end
	M.opts.use_adjust = true
	M.apply()
end, { nargs = "?" })

-- :ThemeLum +/-X | X
vim.api.nvim_create_user_command("ThemeLum", function(cmd)
	local a = cmd.args
	if a == "" then
		vim.notify(("ThemeLum: lum=%.2f"):format(M.opts.lum))
		return
	end
	local v = tonumber(a)
	if not v then
		vim.notify("ThemeLum: expected number like +0.10, -0.05, or 1.00", vim.log.levels.ERROR)
		return
	end
	if is_rel(a) then
		M.opts.lum = clamp(M.opts.lum + v)
	else
		M.opts.lum = clamp(v)
	end
	M.opts.use_adjust = true
	M.apply()
end, { nargs = "?" })

return M
