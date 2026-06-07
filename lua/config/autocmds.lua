local autocmds = {}

function autocmds.init()
	-- Build hooks: react to plugin install/update.
	-- NOTE: must run before the first vim.pack.add() (config.pack)
	vim.api.nvim_create_autocmd("PackChanged", {
		group = vim.api.nvim_create_augroup("pack-build", { clear = true }),
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "telescope-fzf-native.nvim" and kind ~= "delete" then
				vim.system({ "make" }, { cwd = ev.data.path }):wait()
			end
			if name == "nvim-treesitter" and kind == "update" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
			end
		end,
	})
end

return autocmds
