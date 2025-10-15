vim.opt.shortmess:append("sI")

vim.opt.conceallevel = 1

local function floating_select(items, opts, on_choice)
	opts = opts or {}
	-- Create a scratch buffer to hold the list of items.
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)

	-- Calculate window dimensions.
	local height = #items
	local width = 0
	for _, item in ipairs(items) do
		width = math.max(width, vim.fn.strwidth(item))
	end
	width = width + 4 -- Add some horizontal padding.

	-- Create a floating window, centered on the screen.
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
	})

	-- Use the prompt text as a title for the window.
	if opts.prompt then
		vim.api.nvim_win_set_option(win, "winhl", "Normal:NormalFloat")
		-- vim.api.nvim_win_set_title(win, { { (' %s '):format(opts.prompt), 'FloatTitle' } })
	end

	-- This function handles closing the window and calling the final callback.
	local function handle_choice(choice)
		-- It's important to close the window *before* calling the callback.
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		-- Defer the callback to avoid issues with nested UI calls.
		vim.schedule(function()
			on_choice(choice)
		end)
	end

	-- Set keymaps for the selection buffer.
	-- <CR> to confirm, 'q' or <Esc> to cancel.
	vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", {
		callback = function()
			local cursor_pos = vim.api.nvim_win_get_cursor(win)[1]
			handle_choice(items[cursor_pos])
		end,
		noremap = true,
		silent = true,
		nowait = true,
	})

	vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
		callback = function()
			handle_choice(nil)
		end,
		noremap = true,
		silent = true,
		nowait = true,
	})
	vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "", {
		callback = function()
			handle_choice(nil)
		end,
		noremap = true,
		silent = true,
		nowait = true,
	})
end

vim.ui.select = floating_select

local notes_dir = vim.fn.expand("~/documents/notes")

local function toggle_notes()
	local notes = vim.fn.globpath(notes_dir, "*.md", true, true)
	if vim.tbl_isempty(notes) then
		vim.notify("No notes found in " .. notes_dir, vim.log.levels.WARN)
		return
	end

	local note_files = {}
	for _, path in ipairs(notes) do
		table.insert(note_files, vim.fn.fnamemodify(path, ":t"))
	end

	vim.ui.select(note_files, { prompt = "Select note:" }, function(choice)
		if not choice then
			return
		end

		local file_path = notes_dir .. "/" .. choice
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	end)
end

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>n", toggle_notes, { desc = "Toggle notes" })

vim.cmd("syntax on")
vim.opt.termguicolors = true
vim.opt.number = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cmdheight = 0
vim.opt.scrolloff = 3

vim.opt.statusline = "%{expand('%:t:r')} | %l"

vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	command = "startinsert",
	desc = "Start in insert mode.",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("jump_to_the_last_known_cursor_position", { clear = true }),
	pattern = { "*" },
	desc = "When editing a file, always jump to the last known cursor position",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line >= 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	desc = "Close with <q>",
	pattern = {
		"help",
		"man",
		"qf",
		"query",
		"scratch",
		"spectre_panel",
		"quickfix-list",
		"quickfix",
		"diagnostics",
	},
	callback = function(args)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", { buffer = args.buf })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufLeave" }, {
	pattern = "*",
	command = "silent! update",
	desc = "Autosave the file on changes.",
})

require("nvim-treesitter.configs").setup({

	highlight = { enable = true },
})
