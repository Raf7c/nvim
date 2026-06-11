-- Centralized icons for the whole config.
-- Add new icon groups here and reference them with require("utils.icons").
local M = {}

M.diagnostics = {
	error = "❌",
	warn = "⚠️",
	info = "💡",
	hint = "ℹ️",
}

-- gitsigns gutter glyphs
M.git = {
	add = "▎",
	change = "▎",
	delete = "",
	topdelete = "",
	changedelete = "▎",
	untracked = "▎",
}

-- per-file git status (used by the snacks explorer)
M.git_status = {
	added = "✚",
	modified = "",
	deleted = "✖",
	renamed = "󰁕",
	untracked = "",
	ignored = "",
	staged = "",
	unmerged = "",
}

-- lualine custom components
M.statusline = {
	formatters = "󰉼",
	linters = "󰁨",
	branch = "󰊢",
	diff = { added = "󰐕 ", modified = "󰏫 ", removed = "󰍵 " },
}

-- LSP symbol kinds — your own icons, used by navic, blink and snacks.
M.kinds = {
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
}

return M
