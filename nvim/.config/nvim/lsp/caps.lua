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
caps.offsetEncoding = { "utf-16" } -- backwards-compat for servers using this key
