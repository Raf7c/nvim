local M = {}

function M.init()
	vim.pack.add({
		-- the repo is named "nvim", force a clearer name
		{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	})

	require("catppuccin").setup({
		flavour = "mocha",
		-- flavour picked from 'background' (driven by auto-dark-mode)
		background = {
			light = "latte",
			dark = "mocha",
		},
	})

	vim.cmd.colorscheme("catppuccin")
end

return M
