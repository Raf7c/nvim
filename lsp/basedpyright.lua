-- basedpyright overrides; base config (cmd, filetypes, root_markers)
-- comes from nvim-lspconfig and is merged automatically.
return {
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
