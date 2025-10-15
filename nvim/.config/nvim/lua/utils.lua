local M = {}

local settings_cache = {}

--- Stores the main configuration table.
-- @param settings table The settings table to store.
function M.set_settings(settings)
	settings_cache = settings
end

--- Retrieves the stored configuration table.
-- @return table The settings table.
function M.get_settings()
	return settings_cache
end

--- Loads a specific list of modules from a given subdirectory.
-- @param subdir string The subdirectory within /lua
-- @param modules table A list of module names to load from that subdir.
function M.load_modules(subdir, modules)
	for _, module_name in ipairs(modules) do
		local full_module_path = subdir .. "." .. module_name

		-- pcall safely loads the code. If a file has an
		-- error, it won't crash Neovim.
		local ok, err = pcall(require, full_module_path)
		if not ok then
			vim.notify("Error loading module: " .. full_module_path .. "\n" .. err, vim.log.levels.ERROR)
		end
	end
end

return M
