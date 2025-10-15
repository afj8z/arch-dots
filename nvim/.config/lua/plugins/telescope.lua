vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
})

local layout_strategies = require("telescope.pickers.layout_strategies")
layout_strategies.horizontal_fused = function(picker, max_columns, max_lines, layout_config)
	local layout = layout_strategies.horizontal(picker, max_columns, max_lines, layout_config)
	layout.prompt.title = ""
	layout.results.title = ""
	layout.results.height = layout.results.height + 1
	layout.results.borderchars = { "🬂", "▐", "𜴆", "▌", "🬕", "🬨", "𜶛", "𜵏" }
	layout.prompt.borderchars = { "🬂", "▐", "🬭", "▌", "🬕", "🬨", "🬷", "🬲" }
	if layout.preview then
		layout.preview.title = ""
		layout.preview.borderchars = { "🬂", "▐", "🬭", "▌", "🬕", "🬨", "🬷", "🬲" }
	end
	return layout
end

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal_fused",
		layout_config = {
			horizontal_fused = {
				preview_cutoff = 0,
			},
			horizontal = {
				preview_cutoff = 0,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
				layout_strategy = "horizontal_fused",
				border = true,
			},
		},
	},
})
require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
