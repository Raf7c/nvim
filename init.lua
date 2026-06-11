-- Captured as early as possible to measure startup time (see snacks dashboard)
_G.START_TIME = vim.uv.hrtime()

-- Byte-compiled Lua module cache (opt-in, :h vim.loader)
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

for _, mod in ipairs({ "config.opts", "config.keymaps", "config.commands", "config.autocmds", "config.pack" }) do
  require(mod).init()
end



