-- Lua: simple case — stylua formatter, no linter.
return {
	lsp = { "lua_ls" }, -- settings overrides in nvim/lsp/lua_ls.lua
	tools = { "lua-language-server", "stylua" },
	formatters = { lua = { "stylua" } },
}
