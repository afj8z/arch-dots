-- Statusline configuration for Neovim
-- Replace the default mode in cmdline to status line
vim.o.showmode = false

-- == Mode (far left) ==
local function stl_mode()
	-- map vim modes to a 2-char label and your highlight group suffix
	local m = vim.fn.mode(1) -- '1' = show pending/operator modes
	local map = {
		-- Normal/Pending
		n = { "Normal", "Normal" },
		no = { "Pending", "Pending" },
		nov = { "Pending", "Pending" },
		noV = { "Pending", "Pending" },
		["no\22"] = { "Pending", "Pending" },
		nt = { "Normal", "Normal" },

		-- Insert/Replace
		i = { "Insert", "Insert" },
		ic = { "Insert", "Insert" },
		ix = { "Insert", "Insert" },
		R = { "Replace", "Other" },
		Rc = { "Replace", "Other" },
		Rx = { "Replace", "Other" },

		-- Visual/Select
		v = { "Visual", "Visual" },
		V = { "Visual Line", "Visual" },
		["\22"] = { "Visual Block", "Visual" },
		s = { "Select", "Other" },
		S = { "Select Line", "Other" },
		["\19"] = { "Select Block", "Other" },

		-- Command/Ex
		c = { "Command", "Command" },
		cv = { "Ex", "Command" },
		r = { "Confirm", "Command" },
		rm = { "Command", "Command" },
		["r?"] = { "Command", "Command" },

		-- Terminal etc.
		t = { "Terminal", "Other" },
	}
	local entry = map[m] or { "??", "Other" }
	local txt, kind = entry[1], entry[2]

	--   highlight groups:
	--   StatuslineMode{Kind} and StatuslineModeSeparator{Kind}
	return table.concat({
		"%#StatuslineMode" .. kind .. "#",
		" --" .. txt .. "-- ",
		"%*", " " -- reset hl
	})
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return fname .. " "
end

--- @param severity integer
--- @return integer
local function get_lsp_diagnostics_count(severity)
	if not rawget(vim, 'lsp') then
		return 0
	end

	local count = vim.diagnostic.count(0, { serverity = severity })[severity]
	if count == nil then
		return 0
	end

	return count
end

--- @return string
local function python_env()
	local virtual_env = os.getenv 'VIRTUAL_ENV_PROMPT'
	if virtual_env == nil then
		return ''
	end

	virtual_env = virtual_env:gsub('%s+', '') -- delete spaces
	return string.format('%%#StatusLineMedium# %s%%*', virtual_env)
end

--- @return string
local function lsp_active()
	if not rawget(vim, 'lsp') then
		return ''
	end

	local current_buf = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients { bufnr = current_buf }

	local space = '%#StatusLineMedium# %*'

	if #clients > 0 then
		return space .. '%#StatusLineMedium#LSP%*'
	end

	return ''
end

--- @return string
local function diagnostics_error()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.ERROR)
	if count > 0 then
		return string.format('%%#StatusLineLspError# %se%%*', count)
	end

	return ''
end

--- @return string
local function diagnostics_warns()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.WARN)
	if count > 0 then
		return string.format('%%#StatusLineLspWarn# %sw%%*', count)
	end

	return ''
end

--- @return string
local function diagnostics_hint()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.HINT)
	if count > 0 then
		return string.format('%%#StatusLineLspHint# %sh%%*', count)
	end

	return ''
end

--- @return string
local function diagnostics_info()
	local count = get_lsp_diagnostics_count(vim.diagnostic.severity.INFO)
	if count > 0 then
		return string.format('%%#StatusLineLspInfo# %si%%*', count)
	end

	return ''
end
--- @return string
local function file_percentage()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_line_count(0)

	return string.format(
		'%%#StatusLineMedium#  %d%%%% %%*',
		math.ceil(current_line / lines * 100)
	)
end

--- @return string
local function total_lines()
	local lines = vim.fn.line '$'
	return string.format('%%#StatusLineMedium#of %s %%*', lines)
end

--- @param hlgroup string
local function formatted_filetype(hlgroup)
	local filetype = vim.bo.filetype or vim.fn.expand('%:e', false)
	return string.format('%%#%s# %s %%*', hlgroup, filetype)
end

--- @return string
local function git_branch_icon()
	return '%#StatusLineGitBranchIcon#%*'
end

--- @return string
local function git_branch()
	local branch = vim.b.gitsigns_head

	if branch == '' or branch == nil then
		return ''
	end

	return string.format('%%#StatusLineMedium#%s%%*', branch)
end
StatusLine = {}

StatusLine.inactive = function()
	return table.concat {
		formatted_filetype 'StatusLineMode',
	}
end

--- @return string
local function full_git()
	local full = ''
	local space = '%#StatusLineMedium# %*'

	local branch = git_branch()
	if branch ~= '' then
		local icon = git_branch_icon()
		full = full .. space .. icon .. space .. branch .. space
	end

	return full
end
local redeable_filetypes = {
	['qf'] = true,
	['help'] = true,
	['tsplayground'] = true,
}

StatusLine.active = function()
	local mode_str = vim.api.nvim_get_mode().mode
	if mode_str == 't' or mode_str == 'nt' then
		return table.concat {
			stl_mode(),
			'%=',
			'%=',
			file_percentage(),
			total_lines(),
		}
	end

	if redeable_filetypes[vim.bo.filetype] or vim.o.modifiable == false then
		return table.concat {
			formatted_filetype 'StatusLineMode',
			'%=',
			'%=',
			file_percentage(),
			total_lines(),
		}
	end

	local statusline = {
		stl_mode(),
		filename(),
		full_git(),
		'%=',
		'%=',
		'%S ',
		diagnostics_error(),
		diagnostics_warns(),
		diagnostics_hint(),
		diagnostics_info(),
		lsp_active(),
		python_env(),
		file_percentage(),
		total_lines(),
	}

	return table.concat(statusline)
end

vim.opt.statusline = '%!v:lua.StatusLine.active()'
