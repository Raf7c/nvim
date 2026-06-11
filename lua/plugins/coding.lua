-- nvim-treesitter (main branch): install missing parsers, async
require("nvim-treesitter").install({
	"lua",
	"python",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"css",
	"html",
	"yaml",
	"toml",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
	desc = "Tree-sitter highlight when a parser exists",
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- mini.icons: icon provider, exposed under the nvim-web-devicons API for the
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.pairs").setup()
require("mini.cursorword").setup()

-- blink.cmp: completion
local cmp = require("blink.cmp")
local icons = require("utils.icons")

-- Build the fuzzy matcher if needed (no-op once built), per official vim.pack doc
cmp.build():pwait()

cmp.setup({
	-- 'default' preset: <C-y> accept, <C-space> menu/docs, <C-e> hide, <C-n>/<C-p> select
	keymap = {
		preset = "default",
		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		-- <C-k> override eats the preset's signature toggle; rehome it
		["<C-l>"] = { "show_signature", "hide_signature", "fallback" },
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
				-- your own kind icons (matches navic/snacks); falls back to blink's default
				components = {
					kind_icon = {
						text = function(ctx)
							return icons.kinds[ctx.kind] or (ctx.kind_icon .. ctx.icon_gap)
						end,
					},
				},
			},
		},
	},
	signature = { enabled = true },
})
