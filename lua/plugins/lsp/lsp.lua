-- Inline display is handled by tiny-inline-diagnostic, which requires
-- the native virtual_text to stay disabled.
require("tiny-inline-diagnostic").setup({
	options = { use_icons_from_diagnostic = true }, -- reuse the signcolumn icons
})

local icons = require("utils.icons")
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = false, -- required by tiny-inline-diagnostic (its display replaces it)
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.info,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
		},
	},
})

-- LSP engine: aggregates the per-language data files (plugins/lang/*.lua),
-- installs the binaries via mason and enables the servers.
-- Server configs are standalone files in nvim/lsp/*.lua (no nvim-lspconfig).
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
