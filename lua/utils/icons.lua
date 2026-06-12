-- Centralized icons for the whole config
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

-- per-file git status (snacks explorer)
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

-- LSP symbol kinds (navic, blink, snacks)
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
