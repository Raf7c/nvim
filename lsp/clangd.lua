-- clangd: clang-tidy runs inside the server (--clang-tidy), honoring the
-- project's .clang-tidy. Project awareness needs compile_commands.json.
return {
	cmd = {
		"clangd",
		"--background-index", -- index the whole project, not just open files
		"--clang-tidy",
		"--completion-style=detailed", -- one entry per overload
		"--header-insertion=never",
		"--function-arg-placeholders=0",
	},
	-- flags for files NOT covered by a compile_commands.json
	init_options = {
		fallbackFlags = { "-Wall", "-Wextra", "-Werror" },
	},
	-- objc/objcpp would need get_language_id to send the proper languageId
	filetypes = { "c", "cpp" },
	root_markers = {
		{ "compile_commands.json", "compile_flags.txt", ".clangd" },
		{ "CMakeLists.txt", "Makefile", "configure.ac", ".clang-format", ".clang-tidy" },
		{ ".git" },
	},
	on_attach = function(client, bufnr)
		-- jump between foo.c and foo.h
		vim.api.nvim_buf_create_user_command(bufnr, "ClangdSwitchSourceHeader", function()
			client:request("textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(bufnr) }, function(err, result)
				if err or not result then
					vim.notify("No corresponding source/header found", vim.log.levels.INFO)
					return
				end
				vim.cmd.edit(vim.uri_to_fname(result))
			end, bufnr)
		end, { desc = "Switch between source and header" })
	end,
}
