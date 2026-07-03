-- C/C++: clangd + clang-format. The normc42 toggle (config/langs.lua) swaps
-- the C-only tooling for the 42 norm: c_formatter_42 + norminette
-- (definitions in utils/norm42.lua) and clangd without its embedded
-- clang-tidy. cpp is untouched: the norm only applies to C.
local M = {
	lsp = { "clangd" },
	tools = { "clangd", "clang-format" },
	formatters = { c = { "clang-format" }, cpp = { "clang-format" } },
	-- clangd runs clang-tidy internally (no nvim-lint entry); shown in the
	-- statusline only while the flag survives -- normc42 strips it below, so
	-- the runtime cmd check covers both modes (see plugins/ui.lua)
	embedded_linters = {
		clangd = function(client)
			if type(client.config.cmd) == "table" and vim.tbl_contains(client.config.cmd, "--clang-tidy") then
				return "clang-tidy"
			end
		end,
	},
}

if require("config.langs").normc42 ~= false then
	local norm = require("utils.norm42")

	M.formatters.c = { "c_formatter_42" }
	M.custom_formatters = { c_formatter_42 = norm.c_formatter_42 }
	M.linters = {
		c = function()
			return vim.fn.executable("norminette") == 1 and { "norminette" } or {}
		end,
	}
	M.custom_linters = { norminette = norm.norminette }

	-- clangd stays for completion/navigation and the -Wall -Wextra -Werror
	-- compile errors (the school's mandatory flags), but its embedded
	-- clang-tidy would add non-norm diagnostics on top of norminette:
	-- strip the flag from the resolved lsp/clangd.lua cmd.
	M.setup = function()
		local clangd = vim.lsp.config.clangd
		if clangd and type(clangd.cmd) == "table" then
			vim.lsp.config("clangd", {
				cmd = vim.tbl_filter(function(arg)
					return arg ~= "--clang-tidy"
				end, clangd.cmd),
			})
		end
	end
end

return M
