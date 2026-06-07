require("catppuccin").setup({
	flavour = "auto", -- follows 'background' (driven by auto-dark-mode)
	background = {
		light = "latte",
		dark = "mocha",
	},
	integrations = {
		which_key = true,
		navic = {
			enabled = true,
			custom_bg = "NONE",
		},
	},
})

-- "catppuccin-nvim": since nvim 0.12 a builtin "catppuccin" ships with the
-- editor; the plugin's colorscheme was renamed to avoid the conflict
vim.cmd.colorscheme("catppuccin-nvim")
