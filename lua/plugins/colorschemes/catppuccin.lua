-- flavour = "auto" (default) follows 'background', driven by auto-dark-mode
require("catppuccin").setup({
	integrations = {
		which_key = true,
		navic = { enabled = true },
		snacks = { enabled = true },
		mason = true,
	},
})

-- "catppuccin-nvim": since nvim 0.12 a builtin "catppuccin" ships with the
-- editor; the plugin's colorscheme was renamed to avoid the conflict
vim.cmd.colorscheme("catppuccin-nvim")
