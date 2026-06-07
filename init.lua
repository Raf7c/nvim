vim.g.mapleader = " "

for _, mod in ipairs({ "config.opts", "config.keymaps" }) do
  require(mod).init()
end