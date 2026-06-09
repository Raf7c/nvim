-- conform.nvim: formatting engine.
-- Formatters per filetype come from the `formatters` field of plugins/lang/*.lua.
-- A value is either a list of formatters (run in sequence), or a function(bufnr)
-- returning one (conform supports this natively; see utils/project.resolve).
-- Custom formatter definitions come from the `custom_formatters` field.
local formatters_by_ft, custom_formatters = {}, {}
for _, lang in ipairs(require("utils.langs").list()) do
	for ft, formatters in pairs(lang.formatters or {}) do
		formatters_by_ft[ft] = formatters
	end
	for name, def in pairs(lang.custom_formatters or {}) do
		custom_formatters[name] = def
	end
end

require("conform").setup({
	default_format_opts = { lsp_format = "never" }, -- Conform only, never the LSP
	format_on_save = { timeout_ms = 1000 },
	formatters_by_ft = formatters_by_ft,
	formatters = custom_formatters,
})

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer/selection" })
