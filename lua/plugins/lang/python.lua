-- Python: ruff by default (format + lint). As soon as the project configures
-- any tool, only the project's tools are used (no default added to fill gaps).
-- To use a tool you don't have yet, just add its mason name to `tools`.
local project = require("utils.project")

local m = {
	ruff = { "ruff.toml", ".ruff.toml", { "pyproject.toml", has = "[tool.ruff" } },
	isort = { ".isort.cfg", { "pyproject.toml", has = "[tool.isort" } },
	black = { { "pyproject.toml", has = "[tool.black" } },
	autopep8 = { { "pyproject.toml", has = "[tool.autopep8" }, { "setup.cfg", has = "[autopep8]" } },
	docformatter = { { "pyproject.toml", has = "[tool.docformatter" } },
	flake8 = { ".flake8", { "setup.cfg", has = "[flake8]" } },
	pylint = { ".pylintrc", { "pyproject.toml", has = "[tool.pylint" } },
	mypy = { "mypy.ini", ".mypy.ini", { "pyproject.toml", has = "[tool.mypy" } },
	bandit = { ".bandit", { "pyproject.toml", has = "[tool.bandit" } },
}

local tools = project.resolve({
	formatters = {
		{ tools = { "ruff_format" }, markers = m.ruff },
		{ tools = { "isort" }, markers = m.isort },
		{ tools = { "black" }, markers = m.black },
		{ tools = { "autopep8" }, markers = m.autopep8 },
		{ tools = { "docformatter" }, markers = m.docformatter },
	},
	linters = {
		{ tools = { "ruff" }, markers = m.ruff },
		{ tools = { "flake8" }, markers = m.flake8 },
		{ tools = { "pylint" }, markers = m.pylint },
		{ tools = { "mypy" }, markers = m.mypy },
		{ tools = { "bandit" }, markers = m.bandit },
	},
	default_formatters = { "ruff_format" },
	default_linters = { "ruff" },
})

return {
	lsp = { "basedpyright" }, -- config in nvim/lsp/basedpyright.lua
	tools = {
		"basedpyright",
		"ruff",
		"isort",
		"black",
		"autopep8",
		"docformatter",
		"flake8",
		"pylint",
		"mypy",
		"bandit",
	},
	formatters = { python = tools.format },
	linters = { python = tools.lint },
}
