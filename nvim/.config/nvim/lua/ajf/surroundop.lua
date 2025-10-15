local M = {}

-- This table will hold the state of our multi-key operation
local state = {
	mode = nil, -- Will be 'inner' or 'around'
}

-- Helper function to get the delimiter pair from user input
local function get_delimiter_pair()
	vim.api.nvim_echo({ { "Surround with: ", "Question" } }, true, {})
	local char = vim.fn.getcharstr()

	-- Mapping for special characters like b, B, m
	local shorthand = { b = { "(", ")" }, B = { "{", "}" }, m = { '"', '"' } }
	if shorthand[char] then
		return shorthand[char]
	end

	-- Mapping for closing delimiters to their pairs
	local closing = { [")"] = "(", ["]"] = "[", ["}"] = "{" }
	if closing[char] then
		return { closing[char], char }
	end

	-- Default to symmetric characters
	return { char, char }
end

-- The core replacement logic. This is called by both workflows.
local function perform_replacement(start_pos, end_pos)
	local open_char, close_char = get_delimiter_pair()

	-- Handle 'inner' vs 'around' spacing
	local space = (state.mode == "around") and " " or ""
	local open_final = open_char .. space
	local close_final = space .. close_char

	-- Get the lines of text to be modified
	local start_line, start_col = start_pos[1], start_pos[2]
	local end_line, end_col = end_pos[1], end_pos[2]
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)

	if #lines == 0 then
		return
	end

	-- Modify the text
	if #lines == 1 then
		local line_content = lines[1]
		local prefix = line_content:sub(1, start_col)
		local selection = line_content:sub(start_col + 1, end_col + 1)
		local suffix = line_content:sub(end_col + 2)
		lines[1] = prefix .. open_final .. selection .. close_final .. suffix
	else
		local first_line = lines[1]
		local last_line = lines[#lines]
		lines[1] = first_line:sub(1, start_col) .. open_final .. first_line:sub(start_col + 1)
		lines[#lines] = last_line:sub(1, end_col + 1) .. close_final .. last_line:sub(end_col + 2)
	end

	-- Replace the text in the buffer
	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, true, lines)
end

-- This is the operator function for the "wait for motion" workflow
function M.operator_func()
	-- The '[ and '] marks are set by Neovim after a motion
	local start_pos = vim.api.nvim_buf_get_mark(0, "[")
	local end_pos = vim.api.nvim_buf_get_mark(0, "]")
	perform_replacement(start_pos, end_pos)
end

-- This is the main entry point called by the visual 's' mapping
function M.start_surround()
	if vim.fn.mode() ~= "v" and vim.fn.mode() ~= "V" then
		return ""
	end

	-- Step 2: Get 'i' (inner) or 'a' (around)
	vim.api.nvim_echo({ { "(i)nner or (a)round: ", "Question" } }, true, {})
	local mode_char = vim.fn.getcharstr()
	if mode_char == "i" then
		state.mode = "inner"
	elseif mode_char == "a" then
		state.mode = "around"
	else
		vim.api.nvim_echo({ { "Cancelled.", "WarningMsg" } }, false, {})
		return "<Esc>" -- Cancel the operation
	end

	-- Step 3: The Fork logic
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- Fork 1: Single character selected -> wait for a motion
	if start_pos[2] == end_pos[2] and start_pos[3] == end_pos[3] then
		-- Exit visual mode, jump to start of selection, and trigger operator-pending mode
		return "<Esc>`<g@"
		-- Fork 2: Multiple characters selected -> operate on the selection
	else
		perform_replacement({ start_pos[2], start_pos[3] - 1 }, { end_pos[2], end_pos[3] - 1 })
		-- After operating, exit visual mode
		return "<Esc>"
	end
end

-- Your other functions (toggle_boolean, etc.) can remain here
-- ...
return M
