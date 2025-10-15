local map = vim.keymap.set

function RUN_FILE()
	local fpath = vim.api.nvim_buf_get_name(0)
	if fpath == "" then
		vim.notify("No file to run", vim.log.levels.WARN)
		return
	end
	local ftype = vim.bo.filetype
	local map = {
		python = function()
			return { "python3", fpath }
		end,
		lua = function()
			return { "lua", fpath }
		end,
		javascript = function()
			return { "node", fpath }
		end,
		typescript = function()
			if vim.fn.executable("tsx") == 1 then
				return { "tsx", fpath }
			end
			if vim.fn.executable("ts-node") == 1 then
				return { "ts-node", fpath }
			end
			if vim.fn.executable("deno") == 1 then
				return { "deno", "run", fpath }
			end
		end,
		sh = function()
			return { "bash", fpath }
		end,
		bash = function()
			return { "bash", fpath }
		end,
		zsh = function()
			return { "zsh", fpath }
		end,
		ruby = function()
			return { "ruby", fpath }
		end,
		perl = function()
			return { "perl", fpath }
		end,
		php = function()
			return { "php", fpath }
		end,
		r = function()
			return { "Rscript", fpath }
		end,
		julia = function()
			return { "julia", fpath }
		end,
		go = function()
			return { "go", "run", fpath }
		end,
	}
	local ft = map[ftype]

	local cmd = ft and ft() or (vim.fn.executable(fpath) == 1 and { fpath } or nil)
	-- vim.api.nvim_command('split')
	-- vim.api.nvim_command('terminal')
	-- vim.api.nvim_paste(ftype .. " " .. fpath, false, -1)

	local curwin = vim.api.nvim_get_current_win()
	local target = math.max(3, math.floor(vim.api.nvim_win_get_height(curwin) * 0.25))
	local was_equalalways = vim.o.equalalways
	vim.o.equalalways = false
	vim.cmd(("belowright %dsplit"):format(target))

	vim.cmd("enew")
	local termbuf = vim.api.nvim_get_current_buf()
	vim.bo[termbuf].bufhidden = "wipe"
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.signcolumn = "no"
	pcall(vim.diagnostic.disable, termbuf)

	local cwd = vim.fn.fnamemodify(fpath, ":p:h")
	-- jobstart()| with `{term: v:true}`
	vim.fn.termopen(cmd, { cwd = cwd })
	vim.cmd("startinsert")

	vim.cmd("wincmd p")
	vim.o.equalalways = was_equalalways
end

map("n", "<Leader>m", "<cmd>lua RUN_FILE()<CR>")
