-- basedpyright: standalone config (no nvim-lspconfig), used by vim.lsp.enable().
return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		{ "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" },
		{ ".git" },
	},
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
				diagnosticMode = "workspace",
				diagnosticSeverityOverrides = {
					reportUnusedImport = "none",
					reportUnusedVariable = "warning",
					reportUnusedClass = "information",
					reportUnusedFunction = "information",
					reportMissingTypeStubs = "information",
					reportMissingParameterType = "warning",
					reportMissingReturnType = "warning",
					reportGeneralTypeIssues = "error",
					reportOptionalMemberAccess = "warning",
					reportOptionalSubscript = "warning",
					reportPrivateImportUsage = "warning",
				},
				inlayHints = {
					functionReturnTypes = true,
					callArgumentNames = true,
					variableTypes = false,
					pytestParameters = true,
					genericTypes = true,
				},
			},
		},
	},
}
