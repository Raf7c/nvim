-- JS/TS: prettier as default formatter, no linter by default (eslint needs a
-- project config). As soon as the project configures any tool,
-- only the project's tools are used (no default added to fill gaps).
local project = require("utils.project")
local util = require("conform.util")

local m = {
	biome = { "biome.json", "biome.jsonc" },
	eslint = {
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
	},
	prettier = {
		".prettierrc",
		".prettierrc.json",
		".prettierrc.yml",
		".prettierrc.yaml",
		".prettierrc.json5",
		".prettierrc.js",
		".prettierrc.cjs",
		".prettierrc.mjs",
		".prettierrc.toml",
		"prettier.config.js",
		"prettier.config.cjs",
		"prettier.config.mjs",
		{ "package.json", has = '"prettier"' },
	},
}

local tools = project.resolve({
	formatters = {
		{ tools = { "biome-check" }, markers = m.biome },
		{ tools = { "eslint_fix" }, markers = m.eslint }, -- eslint --fix
		{ tools = { "prettier" }, markers = m.prettier },
	},
	linters = {
		{ tools = { "biomejs" }, markers = m.biome },
		{ tools = { "eslint_d" }, markers = m.eslint },
	},
	default_formatters = { "prettier" },
	default_linters = {}, -- eslint needs a config, so no linting by default
})

local formatters, linters = {}, {}
for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
	formatters[ft] = tools.format
	linters[ft] = tools.lint
end

return {
	lsp = { "vtsls" }, -- config in nvim/lsp/vtsls.lua
	tools = { "vtsls", "prettier", "eslint_d", "biome" },
	formatters = formatters,
	linters = linters,
	custom_formatters = {
		-- eslint --fix via eslint_d (project's node_modules first, mason as fallback)
		eslint_fix = {
			command = util.from_node_modules("eslint_d"),
			args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
			cwd = util.root_file(m.eslint),
			require_cwd = true,
		},
	},
}
