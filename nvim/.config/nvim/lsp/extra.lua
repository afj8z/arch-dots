vim.keymap.set("n", "<leader>p", function()
	local basedpyright = vim.lsp.get_clients({
		bufnr = 0,
		name = "basedpyright",
		methos = vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
	})[1]

	if not basedpyright then
		return vim.notify("basedpyright isn't attached to current buffer", vim.log.levels.WARN)
	end

	local settings = basedpyright.config.settings or {}

	settings.basedpyright = settings.basedpyright or {}
	settings.basedpyright.analysis = settings.basedpyright.analysis or {}

	settings.basedpyright.analysis.typeCheckingMode = settings.basedpyright.analysis.typeCheckingMode == "off"
			and "recommended"
		or "basic"

	basedpyright:notify(vim.lsp.protocol.Methods.workspace_didChangeConfiguration, { settings = settings })
	vim.diagnostic.reset(nil, 0)
end, { desc = "Toggle basedpyright type checking" })
