vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, visual = true })
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tmpl",
	callback = function(args)
		local name = vim.api.nvim_buf_get_name(args.buf)
		local base = name:gsub("%.tmpl$", "")
		-- try Neovim's own detector on the stripped name (if available)
		local ft = (vim.filetype and vim.filetype.match) and vim.filetype.match({ filename = base, buf = args.buf })
			or nil

		-- fallback: derive from the last extension of the stripped name
		if not ft then
			local ext = base:match("%.([%w]+)$")
			local map = {
				yml = "yaml",
				ini = "dosini",
				md = "markdown",
				h = "c",
				hpp = "cpp",
				bash = "sh",
			}
			ft = (ext and (map[ext] or ext)) or "text"
		end

		vim.bo[args.buf].filetype = ft
	end,
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

function get_scr_width()
	local width = vim.api.nvim_win_get_width(0)
	local ft = vim.bo.filetype

	local line = width - 5
	if ft == "typst" and width > 85 then
		line = 80
	end
	vim.cmd("set textwidth=" .. line)
end

vim.api.nvim_command("autocmd VimResized * lua get_scr_width()")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
		vim.g.startup_time_ms = string.format("%.2f ms", startuptime * 1000)
	end,
})
