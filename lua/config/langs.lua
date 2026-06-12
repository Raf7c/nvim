-- Central language toggle, consumed by utils/langs.lua.
-- false disables the whole stack of a plugins/lang/<name>.lua file
-- (LSP, mason tools, formatters, linters, setup hook); an absent
-- entry means enabled. Mason binaries are not uninstalled.
return {
	ansible = true,
	c = true,
	normc42 = false, -- not a fiche: flag read by lang/c.lua. true = 42 norm for C (c_formatter_42 + norminette, clangd without clang-tidy); false = clang-format
	css = true,
	docker = true,
	html = true,
	json = true,
	lua = true,
	markdown = true,
	python = true,
	toml = true,
	typescript = true,
	yaml = true,
}
