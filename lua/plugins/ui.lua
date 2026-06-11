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
		{ "<leader>g", group = "Git" },
	},
})

-- nvim-navic: code context (class > method > ...) in the winbar
require("nvim-navic").setup({
	icons = require("utils.icons").kinds,
	lsp = { auto_attach = true },
	highlight = true, -- required by the catppuccin navic integration
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

-- lualine: statusline
local icons = require("utils.icons")

-- Formatters for the current buffer (set by plugins/format.lua via vim.b.active_formatters)
local function formatters()
	local active = vim.b.active_formatters
	if not active or active == "" then
		return ""
	end
	return icons.statusline.formatters .. " " .. active
end

-- Active linters (set by plugins/lint.lua via vim.b.active_linter)
local function linters()
	local active = vim.b.active_linter
	if not active or active == "" then
		return ""
	end
	return icons.statusline.linters .. " " .. active
end

require("lualine").setup({
	-- theme/globalstatus defaults already follow the colorscheme and laststatus = 3
	options = {
		component_separators = "|",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "branch", icon = icons.statusline.branch },
			{
				"diff",
				symbols = icons.statusline.diff,
				source = function()
					local gs = vim.b.gitsigns_status_dict
					if gs then
						return { added = gs.added, modified = gs.changed, removed = gs.removed }
					end
				end,
			},
			{
				"diagnostics",
				symbols = {
					error = icons.diagnostics.error .. " ",
					warn = icons.diagnostics.warn .. " ",
					info = icons.diagnostics.info .. " ",
					hint = icons.diagnostics.hint .. " ",
				},
			},
		},
		lualine_c = { "filename" },
		lualine_x = { formatters, linters, "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
