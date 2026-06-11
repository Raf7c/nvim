local keymaps = {}

function keymaps.init()
	local keymap = vim.keymap

	-- Config
	keymap.set("n", "<leader>re", "<cmd>restart<cr>", { desc = "Restart Neovim (:restart)" })

	keymap.set("n", "<up>", "<nop>", { silent = true })
	keymap.set("n", "<down>", "<nop>", { silent = true })
	keymap.set("n", "<left>", "<nop>", { silent = true })
	keymap.set("n", "<right>", "<nop>", { silent = true })
	keymap.set("n", "q", "<nop>", { silent = true }) -- no macros

	keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
	keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
	keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

	keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
	keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

	keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch", silent = true })

	-- Save
	keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file", silent = true })
end

return keymaps