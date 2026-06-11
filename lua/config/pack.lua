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
		{ src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
		{ src = "https://github.com/folke/which-key.nvim" },
		{ src = "https://github.com/b0o/incline.nvim" },
		{ src = "https://github.com/folke/snacks.nvim" },
		{ src = "https://github.com/nvim-lualine/lualine.nvim" },
		{ src = "https://github.com/lewis6991/gitsigns.nvim" },
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
		{ src = "https://github.com/SmiteshP/nvim-navic" },
		{ src = "https://github.com/christoomey/vim-tmux-navigator" }, -- <C-h/j/k/l> splits <-> tmux panes, no config
		{ src = "https://github.com/saghen/blink.lib" }, -- blink.cmp dependency
		{ src = "https://github.com/saghen/blink.cmp" }, -- v2 (main); fuzzy lib downloaded/built by blink.lua
		{ src = "https://github.com/rafamadriz/friendly-snippets" }, -- snippets for the blink snippet source
		{ src = "https://github.com/mason-org/mason.nvim" },
		{ src = "https://github.com/stevearc/conform.nvim" },
		{ src = "https://github.com/mfussenegger/nvim-lint" },
		{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
		{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	})

	import("plugins")
	import("plugins.colorschemes")
	import("plugins.lsp")
end

return pack
