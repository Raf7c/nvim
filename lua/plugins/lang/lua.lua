-- Lua: simple case — stylua formatter, no linter.
return {
	lsp = { "lua_ls" }, -- config in nvim/lsp/lua_ls.lua
	tools = { "lua-language-server", "stylua" },
	formatters = { lua = { "stylua" } },
}
