vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/JezerM/oil-lsp-diagnostics.nvim" },
})

require("oil").setup({
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},
	skip_confirm_for_simple_edits = false,
	prompt_save_on_select_new_entry = false,
	view_options = {
		show_hidden = true,
		sort = {
			{ "type", "asc" },
			{ "name", "asc" },
		},
	},
	float = {
		border = "solid",
		preview_split = "right",
	},
	preview_win = {
		update_on_cursor_moved = true,
		preview_method = "fast_scratch",
	},
	confirmation = {
		border = "solid",
	},
	progress = {
		border = "solid",
	},
	ssh = {
		border = "solid",
	},
	keymaps_help = {
		border = "solid",
	},
})

require("oil-lsp-diagnostics").setup({
	diagnostic_symbols = {
		error = "E",
		warn = "W",
		info = "I",
		hint = "H",
	},
})

-- Not got this to work yet. Kind of close.
-- vim.keymap.set("n", "<leader-h>", function()
-- 	local state = {
-- 		main_win = nil,
-- 		parent_win = nil,
-- 		preview_win = nil,
-- 	}
-- 	local augroup = "OilTripleView"
-- 	vim.api.nvim_create_augroup(augroup, { clear = true })
--
-- 	local bn = vim.fn.bufname()
-- 	local bnr = vim.fn.bufnr(bn)
-- 	-- local start = vim.fn.getcwd() -- This variable wasn't used
-- 	local entrydir = require("oil").get_current_dir(bnr)
-- 	print(bn, bnr, entrydir)
--
-- 	require("oil").open(entrydir)
-- 	state.main_win = vim.api.nvim_get_current_win() -- ADDED: Capture main window ID
-- 	local main_buf = vim.api.nvim_get_current_buf()
--
-- 	vim.cmd.vsplit()
-- 	state.parent_win = vim.api.nvim_get_current_win() -- ADDED: Capture parent window ID
--
-- 	-- CHANGED: Make left pane open the parent directory from the start
-- 	require("oil").open(vim.fs.dirname(entrydir) or entrydir)
--
-- 	vim.cmd.wincmd("H")
-- 	vim.cmd.wincmd("l")
-- 	require("oil").open_preview()
--
-- 	-- ADDED: Autocommand to update the parent (left) window
-- 	vim.api.nvim_create_autocmd("User", {
-- 		group = augroup,
-- 		pattern = "OilEnter",
-- 		callback = function(args)
-- 			-- Only run if the event happened in our main oil buffer
-- 			if args.buf ~= main_buf then
-- 				return
-- 			end
-- 			-- Get the main window's new directory
-- 			local new_dir = require("oil").get_current_dir(main_buf)
-- 			if not new_dir then
-- 				return
-- 			end
--
-- 			-- Calculate the new parent directory
-- 			local parent_dir = vim.fs.dirname(new_dir) or new_dir
--
-- 			-- Safely update the parent window without stealing focus
-- 			local previous_win = vim.api.nvim_get_current_win()
-- 			if state.parent_win and vim.api.nvim_win_is_valid(state.parent_win) then
-- 				vim.api.nvim_set_current_win(state.parent_win)
-- 				require("oil").open(parent_dir)
-- 				vim.api.nvim_set_current_win(previous_win)
-- 			end
-- 		end,
-- 	})
--
-- 	vim.api.nvim_create_autocmd("CursorHold", {
-- 		group = augroup,
-- 		buffer = main_buf,
-- 		callback = function()
-- 			require("oil").open_preview()
-- 		end,
-- 	})
-- 	vim.api.nvim_create_autocmd("BufWipeout", {
-- 		group = augroup,
-- 		buffer = main_buf,
-- 		callback = function()
-- 			vim.api.nvim_clear_autocmds({ group = augroup })
-- 		end,
-- 	})
-- end, { desc = "Open oil with parent and preview panes" })
