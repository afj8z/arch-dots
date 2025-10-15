local M = {}

--- Toggles boolean words (true/false, True/False) under the cursor.
-- If the word is not a boolean, it performs the default <C-a> action (increment number).
function M.toggle_boolean_or_increment()
	-- Get the word currently under the cursor
	local word = vim.fn.expand("<cword>")

	local toggles = {
		["true"] = "false",
		["false"] = "true",
		["True"] = "False",
		["False"] = "True",
		["TRUE"] = "FALSE",
		["FALSE"] = "TRUE",
	}

	local replacement = toggles[word]

	-- CASE 1: The word is a boolean.
	if replacement then
		-- FIX: Use 'ciw' (change inner word) to preserve surrounding whitespace.
		local keys = "ciw" .. replacement .. "<Esc>"
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", false)

		-- CASE 2: The word is a number.
	elseif tonumber(word) then
		-- FIX: Send the literal terminal code for Ctrl-A ('\x01') to avoid mapping loops.
		-- This makes the increment happen on the FIRST press.
		vim.api.nvim_feedkeys("\x01", "n", false)

		-- CASE 3: The word is neither a boolean nor a number.
	else
		-- Do nothing. This empty block prevents the "freeze" on normal words.
	end
end

function M.smart_space_jump()
	-- Get the current line and the 0-indexed cursor column
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	local char_after_cursor = line:sub(col + 1, col + 1)

	-- A set of boundary characters
	local boundaries = { [")"] = true, ["]"] = true, ["}"] = true, ['"'] = true, ["'"] = true, ["`"] = true }

	-- CASE 1: The cursor is right before a boundary character.
	if boundaries[char_after_cursor] then
		return "<Right> "

		-- CASE 2: The cursor is anywhere else
	else
		return "<Esc>ea"
	end
end

function M.run_file()
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

-- Helper for open_root_todo()
local function find_todo_in_dir(dir)
	for filename in vim.fs.dir(dir) do
		local basename = filename:gsub("%..*$", "")
		if basename:lower() == "todo" then
			return vim.fs.joinpath(dir, filename)
		end
	end
	return nil
end

-- Open cwd root todo file
function M.open_root_todo()
	local markers = { ".git", "Makefile", "package.json", "pyproject.toml", "Cargo.toml", "go.mod", "todo" }

	local root_dir = vim.fs.root(0, markers)

	if root_dir then
		local todo_file = find_todo_in_dir(root_dir)

		if todo_file then
			vim.cmd.edit(todo_file)
			print("Opened project todo: " .. todo_file)
		else
			local new_todo_path = vim.fs.joinpath(root_dir, "todo")
			vim.cmd.edit(new_todo_path)
			print("Created new project todo: " .. new_todo_path)
		end
	else
		local global_todo = vim.fs.normalize("~/.todo")
		vim.cmd.edit(global_todo)
		print("No project root found. Opened global todo: " .. global_todo)
	end
end

function M.surround_motion_with()
	-- This operator funcon will run AFTER the user provides a motion (e.g., 'iw').
	_G.__surround_operator_func = function()
		-- 1. Get the character for the surrounding pair.
		vim.api.nvim_echo({ { "", "Question" } }, true, {})
		local char_code = vim.fn.getchar()

		if char_code == 27 or char_code == 3 then -- Allow canceling with Escape or Ctrl-C
			vim.api.nvim_echo({}, false, {}) -- Clear the prompt
			return
		end
		local user_input_char = vim.fn.nr2char(char_code)
		vim.api.nvim_echo({}, false, {}) -- Clear the prompt

		-- 2. Handle aliases (b, B, m) and determine the delimiter pair.
		local aliases = { b = "(", B = "{", m = "'" }
		local open_char = aliases[user_input_char] or user_input_char

		local closing_pairs = { ["("] = ")", ["["] = "]", ["{"] = "}" }
		local close_char = closing_pairs[open_char] or open_char

		-- 3. Get the text covered by the motion using the '[ and '] marks.
		local start_pos = vim.api.nvim_buf_get_mark(0, "[")
		local end_pos = vim.api.nvim_buf_get_mark(0, "]")
		local start_line, start_col = start_pos[1] - 1, start_pos[2]
		local end_line, end_col = end_pos[1] - 1, end_pos[2] + 1

		local text_to_surround = vim.api.nvim_buf_get_text(0, start_line, start_col, end_line, end_col, {})

		-- 4. Construct the new text by adding the surrounding pair.
		text_to_surround[1] = open_char .. text_to_surround[1]
		text_to_surround[#text_to_surround] = text_to_surround[#text_to_surround] .. close_char

		-- 5. Replace the original text with the new, surrounded text.
		vim.api.nvim_buf_set_text(0, start_line, start_col, end_line, end_col, text_to_surround)
	end

	vim.o.operatorfunc = "v:lua._G.__surround_operator_func"
	return "g@"
end

return M
