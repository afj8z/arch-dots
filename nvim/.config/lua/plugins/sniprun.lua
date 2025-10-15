vim.pack.add({
	{ src = 'https://github.com/michaelb/sniprun' }
})

require('sniprun').setup({
	binary_path = "/home/aidanfleming/.local/target/release/sniprun",
	selected_interpreters = { 'Python3_fifo' },
	repl_enable = { 'Python3_fifo' },
	display = {
		"VirtualTextOk",
		"VirtualText",
		"TerminalWithCode",
	},
	display_options = {
		terminal_position = "horizontal", --# or "horizontal", to open as horizontal split instead of vertical split
		terminal_height = 7,            --# change the terminal display option height (if horizontal)
	},
})

vim.api.nvim_set_keymap('v', '<leader>t', '<Plug>SnipRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', '<Plug>SnipRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>T', ':%SnipRun<CR>', { silent = true })
