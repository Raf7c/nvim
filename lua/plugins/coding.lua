-- Install missing tree-sitter parsers (async, no-op when present).
-- c and lua ship with neovim but are reinstalled on purpose: parser and
-- queries then both come from nvim-treesitter (one consistent source)
require("nvim-treesitter").install({
	"c",
	"cpp",
	"lua",
	"python",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"css",
	"scss",
	"html",
	"yaml",
	"toml",
	"dockerfile",
})

-- no dedicated jsonc parser on the main branch: reuse the json one
vim.treesitter.language.register("json", "jsonc")
-- compound yaml filetypes share the yaml parser
vim.treesitter.language.register("yaml", { "yaml.docker-compose", "yaml.ansible" })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
	desc = "Tree-sitter highlight when a parser exists",
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- mini.icons also impersonates nvim-web-devicons for the plugins that expect it
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.pairs").setup()
require("mini.cursorword").setup()

local cmp = require("blink.cmp")
local icons = require("utils.icons")

-- Build the fuzzy matcher (no-op once built)
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
				components = {
					-- centralized kind icons (utils/icons); blink's as fallback
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
