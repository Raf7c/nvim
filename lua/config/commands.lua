local commands = {}

-- NOTE: temporary, :PackUpdate and :PackDel become builtin commands in nvim 0.13
function commands.init()
	-- :PackUpdate [names...]: update everything, or only the listed plugins
	vim.api.nvim_create_user_command("PackUpdate", function(o)
		vim.pack.update(#o.fargs > 0 and o.fargs or nil)
	end, { nargs = "*", desc = "Update plugins" })

	-- :PackDel name...: delete from disk (also remove the config file)
	vim.api.nvim_create_user_command("PackDel", function(o)
		vim.pack.del(o.fargs)
	end, { nargs = "+", desc = "Delete plugins" })
end

return commands
