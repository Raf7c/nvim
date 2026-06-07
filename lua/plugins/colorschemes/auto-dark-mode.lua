local M = {}

function M.init()
	vim.pack.add({ "https://github.com/f-person/auto-dark-mode.nvim" })

	require("auto-dark-mode").setup({
		update_interval = 1000,
		set_dark_mode = function()
			vim.o.background = "dark"
		end,
		set_light_mode = function()
			vim.o.background = "light"
		end,
	})
end

return M
