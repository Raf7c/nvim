local pack = {}

-- Load every .lua file in a folder (e.g. import("plugins.colorschemes"))
-- Alphabetical order, non-recursive (subfolders are imported separately).
local function import(mod)
	local dir = vim.fn.stdpath("config") .. "/lua/" .. mod:gsub("%.", "/")
	for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
		require(mod .. "." .. vim.fn.fnamemodify(file, ":t:r"))
	end
end

function pack.init()
	-- All plugin sources, installed and loaded here.
	-- Configuration lives in lua/plugins/ (one file per plugin).
	vim.pack.add({
		{ src = "https://github.com/f-person/auto-dark-mode.nvim" },
		{ src = "https://github.com/catppuccin/nvim", name = "catppuccin-nvim" },
		{ src = "https://github.com/folke/which-key.nvim" },
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- incline dependency
		{ src = "https://github.com/b0o/incline.nvim" },
		{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- telescope dependency
		-- pinned to latest release tag, as recommended by the telescope README
		{ src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("*") },
		{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
		{ src = "https://github.com/SmiteshP/nvim-navic" },
		{ src = "https://github.com/christoomey/vim-tmux-navigator" }, -- <C-h/j/k/l> splits <-> tmux panes, no config
		{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
		{ src = "https://github.com/MunifTanjim/nui.nvim" }, -- neo-tree dependency
		{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
	})

	import("plugins")
	import("plugins.colorschemes")
end

return pack
