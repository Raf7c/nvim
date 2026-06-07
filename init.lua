vim.g.mapleader = " "

for _, mod in ipairs({ "config.opts", "config.keymaps", "config.pack" }) do
  require(mod).init()
end