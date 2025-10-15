-- Old configuration snippets I might want to reuse later



-- LSP
-- Diagnostics configuration

local api = vim.api
local diagnostic = vim.diagnostic

api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		if #vim.diagnostic.get(0) == 0 then
			return
		end

		if not vim.b.diagnostics_pos then
			vim.b.diagnostics_pos = { nil, nil }
		end

		local cursor_pos = api.nvim_win_get_cursor(0)

		if not vim.deep_equal(cursor_pos, vim.b.diagnostics_pos) then
			diagnostic.open_float { width = 100 }
		end

		vim.b.diagnostics_pos = cursor_pos
	end,
})
