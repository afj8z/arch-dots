-- lua/bracket_region.lua
local M = {}
local ns = vim.api.nvim_create_namespace("bracket-region")

-- map of bracket pairs
local pairs_map = {
	["("] = ")",
	["["] = "]",
	["{"] = "}",
	[")"] = "(",
	["]"] = "[",
	["}"] = "{",
	-- uncomment if you also want angle brackets:
	-- ["<"] = ">", [">"] = "<",
}

-- return row,col (0-based) of the matching bracket, or nil
local function find_match(row, col, ch)
	local open_pat, close_pat, flags

	-- Use Vim *regex* “very nomagic” prefix so chars match literally.
	local function lit(c) return "\\V" .. c end

	if ch == "(" or ch == "[" or ch == "{" -- or ch == "<"
	then
		open_pat, close_pat, flags = lit(ch), lit(pairs_map[ch]), "W"
	elseif ch == ")" or ch == "]" or ch == "}" -- or ch == ">"
	then
		open_pat, close_pat, flags = lit(pairs_map[ch]), lit(ch), "bW"
	else
		return nil
	end

	-- save and restore view since searchpairpos moves the cursor
	local view = vim.fn.winsaveview()
	-- nvim_win_set_cursor takes 1-based row, 0-based byte col
	pcall(vim.api.nvim_win_set_cursor, 0, { row + 1, col })

	local pos = vim.fn.searchpairpos(open_pat, "", close_pat, flags)
	vim.fn.winrestview(view)

	if type(pos) == "table" and pos[1] and pos[1] > 0 then
		return pos[1] - 1, pos[2] - 1 -- convert to 0-based
	end
	return nil
end

local function get_char_at(row, col)
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
	if col < 0 or col >= #line then return nil end
	return line:sub(col + 1, col + 1)
end

function M.highlight_between()
	-- clear previous highlight
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

	-- only act in normal/insert modes
	local mode = vim.api.nvim_get_mode().mode
	if not (mode == "n" or mode == "i") then return end

	local pos = vim.api.nvim_win_get_cursor(0)
	local row, col = pos[1] - 1, pos[2]

	-- detect if we're ON a bracket; if not, check previous char (insert-mode friendly)
	local ch = get_char_at(row, col)
	if not pairs_map[ch or ""] then
		ch = get_char_at(row, col - 1)
		if pairs_map[ch or ""] then
			col = col - 1
		else
			return -- not at a bracket: nothing to do
		end
	end

	local mr, mc = find_match(row, col, ch)
	if not mr then return end

	-- compute interior region [start .. end)
	local sr, sc, er, ec
	if ch == "(" or ch == "[" or ch == "{" then
		sr, sc = row, col + 1
		er, ec = mr, mc
	else
		sr, sc = mr, mc + 1
		er, ec = row, col
	end

	-- normalize order
	if (er < sr) or (er == sr and ec < sc) then
		sr, er = er, sr
		sc, ec = ec, sc
	end
	-- empty (adjacent) -> skip
	if sr == er and ec <= sc then return end

	vim.api.nvim_buf_set_extmark(0, ns, sr, sc, {
		end_row = er,
		end_col = ec,
		hl_group = "BracketRegion", -- or define your own (e.g. BracketRegion)
		hl_eol = true,
		priority = 200,
	})
end

function M.setup()
	local aug1 = vim.api.nvim_create_augroup("BracketRegionHL", { clear = true })
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = aug1,
		callback = M.highlight_between,
	})

	local aug2 = vim.api.nvim_create_augroup("BracketRegionHL_Clear", { clear = true })
	vim.api.nvim_create_autocmd({ "BufLeave", "InsertLeave" }, {
		group = aug2,
		callback = function() pcall(vim.api.nvim_buf_clear_namespace, 0, ns, 0, -1) end,
	})
end

return M
