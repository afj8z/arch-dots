vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua.git" },
})

local path = require("fzf-lua.path")

get_line_and_path = function(selected, opts)
	local file_and_path = path.entry_to_file(selected[1], opts).stripped
	vim.print(file_and_path)
	if vim.o.clipboard == "unnamed" then
		vim.fn.setreg([[*]], file_and_path)
	elseif vim.o.clipboard == "unnamedplus" then
		vim.fn.setreg([[+]], file_and_path)
	else
		vim.fn.setreg([["]], file_and_path)
	end
	-- copy to the yank register regardless
	vim.fn.setreg([[0]], file_and_path)
end

require("fzf-lua").setup({
	"border-fused",
	fzf_opts = {
		["--wrap"] = false,
		["--layout"] = "default",
		["ansi"] = false,
	},
	previewers = {
		builtin = {
			syntax_limit_b = -102400, -- 100KB limit on highlighting files
		},
	},
	winopts = {
		preview = {
			default = "bat_native",
			wrap = false,
			layout = "horizontal",
			horizontal = "right:50%",
		},
		border = "none",
		backdrop = 100,
		height = 1,
		width = 1,
	},
	fzf_colors = {
		["bg"] = { { "FloatBorder" } },
		["gutter"] = "-1",
	},
	grep = {
		rg_glob = true,
		-- first returned string is the new search query
		-- second returned string are (optional) additional rg flags
		-- @return string, string?
		rg_glob_fn = function(query, opts)
			local regex, flags = query:match("^(.-)%s%-%-(.*)$")
			-- If no separator is detected will return the original query
			return (regex or query), flags
		end,
	},
	defaults = {
		git_icons = false,
		file_icons = false,
		color_icons = false,
		formatter = "path.filename_first",
	},
	actions = {
		files = {
			true,
			["ctrl-y"] = { fn = get_line_and_path, exec_silent = true },
		},
	},
})

vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "FZF Grep" })
vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", require("fzf-lua").helptags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fm", require("fzf-lua").marks, { desc = "Marks" })
vim.keymap.set("n", "<leader>fr", require("fzf-lua").registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>fF", require("fzf-lua").resume, { desc = "FZF Resume" })
vim.keymap.set("n", "<leader>fu", require("fzf-lua").changes, { desc = "FZF Changes" })
vim.keymap.set("n", "<leader>ft", require("fzf-lua").tmux_buffers, { desc = "FZF Tmux" })
vim.keymap.set("n", "<leader>fv", ":lua require('fzf-lua').files({ cwd = '~/.config/nvim' })<CR>")
