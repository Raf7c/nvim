local opts = {}

function opts.init()
	local opt = vim.opt

	-- Providers: unused, disabled to silence checkhealth warnings (:h provider)
	vim.g.loaded_node_provider = 0
	vim.g.loaded_perl_provider = 0
	vim.g.loaded_python3_provider = 0
	vim.g.loaded_ruby_provider = 0

	-- netrw
	vim.g.netrw_banner = 0

	-- Interface
	opt.number = true
	opt.relativenumber = true
	opt.cursorline = true
	opt.wrap = false
	opt.signcolumn = "yes"
	opt.list = true
	opt.listchars:append("eol:↴")
	opt.termguicolors = true
	opt.guicursor = ""
	opt.scrolloff = 8
	opt.colorcolumn = "80"
	opt.laststatus = 3
	opt.cmdheight = 0

	-- Indentation: global DEFAULT (overridden by after/ftplugin/)
	opt.tabstop = 4
	opt.softtabstop = 4
	opt.shiftwidth = 4
	opt.expandtab = false

	-- Search
	opt.ignorecase = true
	opt.smartcase = true
	opt.inccommand = "split"

	-- Completion
	opt.completeopt = "menuone,noselect,fuzzy,nosort"
	opt.shortmess:append("c")

	-- Files
	opt.autoread = true
	opt.autowrite = true
	opt.confirm = true
	opt.swapfile = false
	opt.backup = false
	opt.isfname:append("@-@")

	-- Splits
	opt.splitbelow = true
	opt.splitright = true

	-- Mouse
	opt.mouse = "a"
	opt.mousescroll = "ver:3,hor:0"
	opt.timeout = true
	opt.timeoutlen = 300

	-- Clipboard
	opt.clipboard = "unnamedplus"

	-- Undo
	opt.undofile = true
	opt.undodir = vim.fn.stdpath("data") .. "/undo"

	-- Highlight on yank
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		callback = function()
			vim.hl.on_yank()
		end,
	})
end

return opts
