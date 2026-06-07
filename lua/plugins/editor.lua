-- telescope.nvim: fuzzy finder
local telescope = require("telescope")

telescope.setup({
	defaults = {
		prompt_prefix = "🔍 ",
		selection_caret = " ",
		path_display = { "truncate" },
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.50,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
	extensions = {
		["ui-select"] = require("telescope.themes").get_dropdown({}),
	},
})

telescope.load_extension("fzf")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")
local keymap = vim.keymap

keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
keymap.set("n", "<leader>fhh", builtin.help_tags, { desc = "Help Tags" })
keymap.set("n", "<leader>fhc", builtin.commands, { desc = "Commands" })
keymap.set("n", "<leader>fhk", builtin.keymaps, { desc = "Keymaps" })

-- neo-tree.nvim: file explorer
require("neo-tree").setup({
	window = {
		position = "float",
		popup = {
			border = "rounded",
		},
		mappings = {
			["o"] = "open",
			["s"] = "open_split",
			["v"] = "open_vsplit",
		},
	},
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
	},
})

keymap.set("n", "<leader>ee", "<cmd>Neotree toggle reveal position=float<cr>", { desc = "Toggle Neotree (Float)" })
keymap.set("n", "<leader>et", "<cmd>Neotree toggle reveal position=left<cr>", { desc = "Toggle Neotree (Left)" })
