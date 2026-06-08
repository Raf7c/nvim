-- Python: everything specific to this language lives here.
-- Indentation (PEP8) is handled by after/ftplugin/python.lua.
-- Later: formatters/linters (ruff or isort+autopep8/flake8) via conform/nvim-lint.
return {
	lsp = { "basedpyright" }, -- settings overrides in nvim/lsp/basedpyright.lua
	tools = { "basedpyright" },
}
