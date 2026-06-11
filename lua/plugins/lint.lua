-- Linting engine. Linters come from the `linters`/`custom_linters` fields of
-- plugins/lang/*.lua; a value is a list or a function(bufnr)
-- (project-aware selection via utils/project.resolve).
local linters_by_ft = {}
for _, lang in ipairs(require("utils.langs").list()) do
	for ft, linters in pairs(lang.linters or {}) do
		linters_by_ft[ft] = linters
	end
	for name, def in pairs(lang.custom_linters or {}) do
		require("lint").linters[name] = def
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = vim.api.nvim_create_augroup("lint", { clear = true }),
	callback = function(args)
		local linters = linters_by_ft[vim.bo[args.buf].filetype]
		if type(linters) == "function" then
			linters = linters(args.buf)
		end
		if linters and #linters > 0 then
			vim.b[args.buf].active_linter = table.concat(linters, ", ") -- read by the statusline
			require("lint").try_lint(linters)
		else
			vim.b[args.buf].active_linter = nil
		end
	end,
})
