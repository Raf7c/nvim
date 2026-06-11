-- vtsls: standalone config (no nvim-lspconfig), used by vim.lsp.enable().
-- Wraps VSCode's TypeScript extension; settings follow the VSCode schema.
-- No Deno-exclusion logic (add it back if a Deno project ever shows up).
local inlay_hints = {
	parameterNames = { enabled = "literals" }, -- "all" is noisier
	parameterTypes = { enabled = true },
	functionLikeReturnTypes = { enabled = true },
	variableTypes = { enabled = false },
}

return {
	cmd = { "vtsls", "--stdio" },
	init_options = { hostInfo = "neovim" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { { "tsconfig.json", "jsconfig.json", "package.json" }, { ".git" } },
	settings = {
		vtsls = {
			autoUseWorkspaceTsdk = true, -- use the project's typescript when present
			experimental = {
				completion = { enableServerSideFuzzyMatch = true }, -- filter in the server, faster on big projects
			},
		},
		typescript = {
			inlayHints = inlay_hints,
			updateImportsOnFileMove = { enabled = "always" }, -- rewrite imports on file rename/move
			suggest = { completeFunctionCalls = true }, -- complete f(arg1, arg2) as a snippet
		},
		javascript = {
			inlayHints = inlay_hints,
			updateImportsOnFileMove = { enabled = "always" },
			suggest = { completeFunctionCalls = true },
		},
	},
}
