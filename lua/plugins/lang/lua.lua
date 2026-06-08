-- Lua: everything specific to this language lives here.
-- Optional fields: enabled (boolean or function), setup (function,
-- for language-specific plugins), and later: formatters, linters.
return {
	lsp = { "lua_ls" }, -- servers to enable (overrides in nvim/lsp/)
	tools = { "lua-language-server", "stylua" }, -- mason binaries
}
