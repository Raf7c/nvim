-- lua_ls: standalone config (no nvim-lspconfig), used by vim.lsp.enable().
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- nested lists = equal priority within a group (:h vim.lsp.Config)
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, { ".stylua.toml", "stylua.toml" }, { ".git" } },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Neovim's Lua; wrong for standalone Lua 5.x projects
			},
			diagnostics = {
				globals = { "vim" }, -- don't warn about the vim global
				disable = { "missing-fields" }, -- too noisy on partial setup() tables
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME .. "/lua" }, -- vim.* API types/completion
			},
			completion = {
				callSnippet = "Replace",
			},
			format = {
				enable = false, -- stylua via conform
			},
			hint = {
				enable = true, -- shown only when toggled (<leader>ch)
				setType = true,
			},
		},
	},
}
