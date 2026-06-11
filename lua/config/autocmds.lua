local autocmds = {}

function autocmds.init()
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
		desc = "Highlight when yanking (copying) text",
		callback = function()
			vim.hl.on_yank()
		end,
	})

	-- Plugin build hooks. NOTE: must run before the first vim.pack.add() (config.pack)
	vim.api.nvim_create_autocmd("PackChanged", {
		group = vim.api.nvim_create_augroup("pack-build", { clear = true }),
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			-- "install" is deliberately ignored: coding.lua runs install() at
			-- startup, which compiles missing parsers on a fresh machine
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
