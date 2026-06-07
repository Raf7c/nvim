-- which-key.nvim: popup with available keymaps
require("which-key").setup({
	preset = "helix",
	win = {
		border = "rounded",
	},
	spec = {
		{ "<leader>w", group = "Windows" },
		{ "<leader>t", group = "Tabs" },
		{ "<leader>x", group = "Diagnostics" },
		{ "<leader>e", group = "Explorer" },
		{ "<leader>f", group = "Find" },
		{ "<leader>fh", group = "Help" },
		{ "<leader>s", group = "Search" },
		{ "<leader>sn", group = "Notifications" },
		{ "<leader>c", group = "LSP" },
		{ "<leader>cw", group = "Workspace" },
	},
})

-- nvim-navic: code context (class > method > ...) in the winbar
require("nvim-navic").setup({
	icons = {
		File = "󰈙 ",
		Module = "󰏗 ",
		Namespace = "󰌗 ",
		Package = "󰏖 ",
		Class = "󰌗 ",
		Method = "󰆧 ",
		Property = "󰜢 ",
		Field = "󰜢 ",
		Constructor = " ",
		Enum = "󰕘 ",
		Interface = "󰕘 ",
		Function = "󰊕 ",
		Variable = "󰆧 ",
		Constant = "󰏿 ",
		String = "󰀬 ",
		Number = "󰎠 ",
		Boolean = "◩ ",
		Array = "󰅪 ",
		Object = "󰅩 ",
		Key = "󰌋 ",
		Null = "󰟢 ",
		EnumMember = " ",
		Struct = "󰌗 ",
		Event = " ",
		Operator = "󰆕 ",
		TypeParameter = "󰊄 ",
	},
	lsp = { auto_attach = true },
	highlight = true,
	separator = " › ",
	depth_limit = 5,
	depth_limit_indicator = "…",
})

-- Global winbar: avoids setting vim.wo on the wrong window during LspAttach (nvim-navic doc)
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- incline.nvim: floating filename in each window
local helpers = require("incline.helpers")
local devicons = require("nvim-web-devicons")

-- 'mantle' color of the active catppuccin flavour (fallback if unavailable)
local function mantle_bg()
	local ok, palettes = pcall(require, "catppuccin.palettes")
	return ok and palettes.get_palette().mantle or "#44406e"
end

require("incline").setup({
	window = {
		padding = 0,
		margin = { horizontal = 0, vertical = 0 },
	},
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if filename == "" then
			filename = "[No Name]"
		end
		local icon, color = devicons.get_icon_color(filename)
		return {
			icon and { " ", icon, " ", guibg = color, guifg = helpers.contrast_color(color) } or "",
			" ",
			{ filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
			" ",
			guibg = mantle_bg(),
		}
	end,
})
