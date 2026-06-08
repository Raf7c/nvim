-- Diagnostics (defaults kept: underline = true, update_in_insert = false)
-- Inline display is handled by tiny-inline-diagnostic, which requires
-- the native virtual_text to stay disabled (its default since nvim 0.11).
require("tiny-inline-diagnostic").setup()

vim.diagnostic.config({
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "❌",
			[vim.diagnostic.severity.WARN] = "⚠️",
			[vim.diagnostic.severity.INFO] = "💡",
			[vim.diagnostic.severity.HINT] = "ℹ️",
		},
	},
})

-- LSP engine: aggregates the per-language data files (plugins/lang/*.lua),
-- installs the binaries via mason and enables the servers.
-- Server configs are resolved from nvim/lsp/*.lua + nvim-lspconfig.
local servers, tools = {}, {}
local dir = vim.fn.stdpath("config") .. "/lua/plugins/lang"
for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
	local lang = require("plugins.lang." .. vim.fn.fnamemodify(file, ":t:r"))
	local enabled = lang.enabled
	if type(enabled) == "function" then
		enabled = enabled()
	end
	if enabled ~= false then
		vim.list_extend(servers, lang.lsp or {})
		vim.list_extend(tools, lang.tools or {})
		if lang.setup then
			lang.setup() -- language-specific plugin configuration
		end
	end
end

require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-tool-installer").setup({ ensure_installed = tools })

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })

vim.lsp.enable(servers)
