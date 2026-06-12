-- flavour = "auto" (default) follows 'background', driven by auto-dark-mode
require("catppuccin").setup({
	integrations = {
		which_key = true,
		navic = { enabled = true },
		snacks = { enabled = true },
		mason = true,
	},
})

-- "catppuccin-nvim": nvim 0.12 ships a builtin "catppuccin" colorscheme;
-- the plugin renamed its entry point to avoid the conflict
vim.cmd.colorscheme("catppuccin-nvim")
