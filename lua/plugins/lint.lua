-- nvim-lint: linting engine.
-- Linters per filetype come from the `linters` field of plugins/lang/*.lua.
-- A value is either a list of linters, or a function(bufnr) returning one
-- (e.g. built with utils/project.resolve for project-aware selection).
-- Custom linter definitions come from the `custom_linters` field.
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
			require("lint").try_lint(linters)
		end
	end,
})
