-- Aggregates the plugins/lang/*.lua data files for the engines
-- (plugins/lsp/lsp.lua, plugins/format.lua, plugins/lint.lua).
-- config/langs.lua is the on/off switchboard; a lang file can also
-- disable itself with an `enabled` field (boolean or function).
local M = {}

local toggles = require("config.langs")

function M.list()
	local langs = {}
	local dir = vim.fn.stdpath("config") .. "/lua/plugins/lang"
	for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
		local name = vim.fn.fnamemodify(file, ":t:r")
		if toggles[name] ~= false then
			local lang = require("plugins.lang." .. name)
			local enabled = lang.enabled
			if type(enabled) == "function" then
				enabled = enabled()
			end
			if enabled ~= false then
				table.insert(langs, lang)
			end
		end
	end
	return langs
end

return M
