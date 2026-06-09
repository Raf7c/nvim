-- nvim-treesitter (main branch): install missing parsers, async
require("nvim-treesitter").install({
	"lua",
	"python",
	"javascript",
	"typescript",
	"tsx",
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Tree-sitter highlight when a parser exists",
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- indent-blankline.nvim: indentation guides
require("ibl").setup({
	indent = {
		char = "│",
		tab_char = "│",
	},
	scope = {
		show_end = false,
	},
	exclude = {
		filetypes = {
			"neo-tree",
		},
	},
})
