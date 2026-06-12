return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- nested lists = priority groups (:h vim.lsp.Config)
	root_markers = { { ".luarc.json", ".luarc.jsonc", ".emmyrc.json" }, { ".stylua.toml", "stylua.toml" }, { ".git" } },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT", -- Neovim's Lua
				-- resolve require("config.opts") -> lua/config/opts.lua, the
				-- way Neovim loads modules (goto-definition on module names)
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			diagnostics = {
				globals = { "vim", "Snacks", "MiniIcons" }, -- runtime globals
				disable = { "missing-fields" },
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
