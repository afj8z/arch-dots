require("config")
require("lsp.lsp")
require("plugins")

-- Enable custom plugin
require("plugins.bracket_region").setup()

-- Fix background color
-- vim.api.nvim_set_hl(0, 'Normal', { bg = '#262424' })
