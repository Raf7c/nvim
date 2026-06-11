-- Formatting engine. Formatters come from the `formatters`/`custom_formatters`
-- fields of plugins/lang/*.lua; a value is a list or a function(bufnr)
-- (project-aware selection via utils/project.resolve).
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

-- Formatters for the current buffer, memoized per buffer for the statusline
-- (read by plugins/lualine.lua; same pattern as vim.b.active_linter)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("statusline-formatters", { clear = true }),
	callback = function(args)
		local names = {}
		for _, f in ipairs(require("conform").list_formatters(args.buf)) do
			names[#names + 1] = f.name
		end
		vim.b[args.buf].active_formatters = table.concat(names, ", ")
	end,
})
