-- Diagnostics (global keymaps)
local keymap = vim.keymap

keymap.set("n", "[n", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous Diagnostic", silent = true })
keymap.set("n", "]n", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic", silent = true })
keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Previous Error", silent = true })
keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Error", silent = true })
keymap.set("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Show Diagnostic", silent = true })
keymap.set("n", "<leader>xD", "<cmd>Telescope diagnostics<cr>", { desc = "All Diagnostics", silent = true })
keymap.set("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Quickfix Diagnostics", silent = true })

-- LSP (buffer-local, on attach)
-- Neovim already provides defaults: K hover, grn rename, gra code action,
-- grr references, gri implementation, grt type definition, gO symbols,
-- <C-s> signature help (insert). Below: personal additions only.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
	callback = function(ev)
		local map = function(mode, lhs, rhs, desc)
			keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc, silent = true })
		end

		-- Navigation
		map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
		map("n", "<leader>cr", vim.lsp.buf.references, "References")
		map("n", "<leader>ct", vim.lsp.buf.type_definition, "Type Definition")

		-- Actions
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("n", "<leader>cR", vim.lsp.buf.rename, "Rename Symbol")

		-- Symbols
		map("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols")
		map("n", "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols")

		map("n", "<leader>ci", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			map("n", "<leader>ch", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
			end, "Toggle Inlay Hints")
		end
	end,
})
