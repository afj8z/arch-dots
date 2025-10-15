vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = "term://*",
	callback = function(args)
		pcall(vim.diagnostic.disable, args.buf)
		local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
		for _, client in ipairs(get_clients({ bufnr = args.buf }) or {}) do
			pcall(vim.lsp.buf_detach_client, args.buf, client.id)
		end
	end,
})

local function run_current_file_in_split()
	if vim.bo.modified then vim.cmd.write() end
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("No file to run", vim.log.levels.WARN)
		return
	end

	local first = (vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or "")
	local cmd
	if first:sub(1, 2) == "#!" then
		local she = first:sub(3):gsub("^%s+", "")
		local parts = vim.split(she, "%s+")
		if parts[1]:find("env$") and parts[2] then
			cmd = { parts[1], parts[2], file }
		else
			cmd = { parts[1], file }
		end
	end
	if not cmd then
		local ft = vim.bo.filetype
		local map = {
			python = function() return { "python3", file } end,
			lua = function() return { "lua", file } end,
			javascript = function() return { "node", file } end,
			typescript = function()
				if vim.fn.executable("tsx") == 1 then return { "tsx", file } end
				if vim.fn.executable("ts-node") == 1 then return { "ts-node", file } end
				if vim.fn.executable("deno") == 1 then return { "deno", "run", file } end
			end,
			sh = function() return { "bash", file } end,
			bash = function() return { "bash", file } end,
			zsh = function() return { "zsh", file } end,
			ruby = function() return { "ruby", file } end,
			perl = function() return { "perl", file } end,
			php = function() return { "php", file } end,
			r = function() return { "Rscript", file } end,
			julia = function() return { "julia", file } end,
			go = function() return { "go", "run", file } end,
		}
		local f = map[ft]
		cmd = f and f() or (vim.fn.executable(file) == 1 and { file } or nil)
	end
	if not cmd then
		vim.notify("No runner for this filetype and no shebang/executable file.", vim.log.levels.ERROR)
		return
	end

	local curwin = vim.api.nvim_get_current_win()
	local target = math.max(3, math.floor(vim.api.nvim_win_get_height(curwin) * 0.25))
	local was_equalalways = vim.o.equalalways
	vim.o.equalalways = false
	vim.cmd(("belowright %dsplit"):format(target))
	local termwin = vim.api.nvim_get_current_win()

	vim.cmd("enew")
	local termbuf = vim.api.nvim_get_current_buf()
	vim.bo[termbuf].bufhidden = "wipe"
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.signcolumn = "no"
	pcall(vim.diagnostic.disable, termbuf)

	local cwd = vim.fn.fnamemodify(file, ":p:h")
	vim.fn.termopen(cmd, { cwd = cwd })
	vim.cmd("startinsert")

	vim.cmd("wincmd p")
	vim.o.equalalways = was_equalalways
end


vim.api.nvim_create_user_command("RunFile", run_current_file_in_split, {})

-- vim.keymap.set("n", "<leader>t", "<cmd>RunFile<cr>", { desc = "Run current file in split terminal" })
