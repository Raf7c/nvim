-- blink.cmp: completion engine
local cmp = require("blink.cmp")

-- Build the fuzzy matcher if needed (no-op once built), per official vim.pack doc
cmp.build():pwait()

cmp.setup({
	-- 'default' preset: <C-y> accept, <C-space> menu/docs, <C-e> hide, <C-n>/<C-p> select
	keymap = {
		preset = "default",
		["<C-CR>"] = { "accept", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
		menu = {
			border = "rounded",
			min_width = 24,
			max_height = 12,
			draw = {
				treesitter = { "lsp" },
			},
		},
	},
	signature = { enabled = true },
})
