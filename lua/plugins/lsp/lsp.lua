-- Diagnostics (defaults kept: underline = true, update_in_insert = false)
-- Inline display is handled by tiny-inline-diagnostic, which requires
-- the native virtual_text to stay disabled.
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
for _, lang in ipairs(require("utils.langs").list()) do
	vim.list_extend(servers, lang.lsp or {})
	vim.list_extend(tools, lang.tools or {})
	if lang.setup then
		lang.setup() -- language-specific plugin configuration
	end
end

require("mason").setup({
	-- Project/system binaries take precedence;
	-- mason is only the fallback when nothing else provides the tool.
	PATH = "append",
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
