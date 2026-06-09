-- Aggregator for the per-language data files (plugins/lang/*.lua).
-- Used by the engines: plugins/lsp/lsp.lua, plugins/format.lua, plugins/lint.lua.
local M = {}

-- Returns the list of enabled language modules
function M.list()
	local langs = {}
	local dir = vim.fn.stdpath("config") .. "/lua/plugins/lang"
	for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
		local lang = require("plugins.lang." .. vim.fn.fnamemodify(file, ":t:r"))
		local enabled = lang.enabled
		if type(enabled) == "function" then
			enabled = enabled()
		end
		if enabled ~= false then
			table.insert(langs, lang)
		end
	end
	return langs
end

return M
