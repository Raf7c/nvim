local keymaps = {}

function keymaps.init()
  local keymap = vim.keymap

  -- No arrow key allowed
  vim.keymap.set("n", "<up>", "<nop>", { silent = true })
  vim.keymap.set("n", "<down>", "<nop>", { silent = true })
  vim.keymap.set("n", "<left>", "<nop>", { silent = true })
  vim.keymap.set("n", "<right>", "<nop>", { silent = true })
  -- Remove macro key since I don't use it
  vim.keymap.set("n", "q", "<nop>", { silent = true })

  -- Save
  vim.keymap.set("n", "<C-S>", "<CMD>w<CR>", { silent = true, desc = "Save file" })
  
  -- Window
  keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Close Window" })
  keymap.set("n", "<leader>ws", "<C-W>s", { desc = "Split Below" })
  keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split Right" })

  -- Tab
  vim.keymap.set("n", "<leader>tt", "<CMD>tabnew<CR>", { desc = "New Tab", silent = true })
  vim.keymap.set("n", "<leader>td", "<CMD>tabclose<CR>", { desc = "Close Tab", silent = true })
  vim.keymap.set("n", "<leader>tn", "<CMD>tabnext<CR>", { desc = "Next tab", silent = true })
  vim.keymap.set("n", "<leader>tp", "<CMD>tabprev<CR>", { desc = "Prev tab", silent = true })
end
return keymaps