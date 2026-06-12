-- Lua: lua_ls + stylua
return {
	lsp = { "lua_ls" },
	tools = { "lua-language-server", "stylua" },
	formatters = { lua = { "stylua" } },
}
