local pack = {}

-- Load every .lua file in a folder (e.g. import("plugins.colorschemes"))
-- Alphabetical order, non-recursive (subfolders are imported separately).
local function import(mod)
	local dir = vim.fn.stdpath("config") .. "/lua/" .. mod:gsub("%.", "/")
	for _, file in ipairs(vim.fn.globpath(dir, "*.lua", false, true)) do
		require(mod .. "." .. vim.fn.fnamemodify(file, ":t:r")).init()
	end
end

function pack.init()
	-- :PackUpdate [names...]: update everything, or only the listed plugins
	vim.api.nvim_create_user_command("PackUpdate", function(o)
		vim.pack.update(#o.fargs > 0 and o.fargs or nil)
	end, { nargs = "*", desc = "Update plugins" })

	-- :PackDel name...: delete from disk (also remove the config file)
	vim.api.nvim_create_user_command("PackDel", function(o)
		vim.pack.del(o.fargs)
	end, { nargs = "+", desc = "Delete plugins" })

	import("plugins")
	import("plugins.colorschemes")
end

return pack
