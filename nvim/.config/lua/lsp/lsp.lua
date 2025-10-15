local diagnostic = vim.diagnostic
local map = vim.keymap.set

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"basedpyright",
		"lua_ls",
		"biome",
		"tinymist",
		"emmet_ls",
		"bashls",
		"prettierd",
		"black",
		"ruff",
		"eslint_d",
		"shellcheck",
		"stylua",
		"prettier",
		"json-lsp",
		"marksman"
	},
	auto_update = false,
	run_on_start = true,
})

local caps = vim.lsp.protocol.make_client_capabilities()
do
	local ok, blink = pcall(require, "blink.cmp")
	if ok and blink.get_lsp_capabilities then
		caps = blink.get_lsp_capabilities(caps)
	end
end

-- Prefer a single position encoding for all servers:
caps.general = caps.general or {}
caps.general.positionEncodings = { "utf-16", "utf-8" } -- prefer utf-16
caps.offsetEncoding = { "utf-16" }                     -- backwards-compat for servers using this key
-- includes fix for `vim` global
vim.lsp.config("lua_ls", {
	capabilities = caps,
	settings = {
		Lua = {
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	capabilities = caps,
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- let Ruff handle imports
			-- analysis = { typeCheckingMode = "standard" }, -- optional
		},
	},
})
-- LspAttach keymaps
vim.api.nvim_create_autocmd(
	"LspAttach",
	{ --  Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Enable completion triggered by <c-x><c-o>
			local opts = { buffer = ev.buf }
			map("n", "gr", vim.lsp.buf.references, opts)
			map("n", "gd", vim.lsp.buf.definition, opts)
			map("n", "<leader>dn", vim.lsp.buf.rename, opts)
			map("n", "<leader>da", vim.lsp.buf.code_action, opts)
			map("n", "<leader>dd", function()
				vim.diagnostic.open_float({
					border = "rounded",
				})
			end, opts)
		end,
	}
)

-- Diagnostics
vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "I",
			[vim.diagnostic.severity.HINT] = "H",
		},
	},
	severity_sort = true,
	float = {
		source = true,
		scope = "line",
		header = "Diagnostics:",
		prefix = " ",
		border = "single",
	},
})

local set_qflist = function(buf_num, severity)
	local diagnostics = nil
	diagnostics = diagnostic.get(buf_num, { severity = severity })

	local qf_items = diagnostic.toqflist(diagnostics)
	vim.fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })

	vim.cmd([[copen]])
end

map("n", "<space>dw", diagnostic.setqflist, { desc = "put window diagnostics to qf" })

map("n", "<space>db", function()
	set_qflist(0)
end, { desc = "put buffer diagnostics to qf" })
