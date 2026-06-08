-- lua_ls overrides; base config (cmd, filetypes, root_markers)
-- comes from nvim-lspconfig and is merged automatically.
return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- don't warn about the vim global
			},
		},
	},
}
