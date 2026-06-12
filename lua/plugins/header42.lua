-- 42-header.nvim: :Stdheader inserts the school header (any filetype,
-- follows 'commentstring'), refreshed on save.
require("42header").setup({
	default_map = false, -- :Stdheader only, no <F1>
	auto_update = true,
	-- setup opts instead of the too-generic vim.g.user/vim.g.mail globals;
	-- also beats the $USER env var (macOS would impose the system user)
	user = "racongiu", -- 42 login
	mail = "racongiu@student.42.fr",
})
