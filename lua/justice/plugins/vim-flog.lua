return {
	"rbong/vim-flog",
	lazy = true,
	cmd = { "Flog", "Flogsplit", "Floggit" },
	dependencies = {
		"tpope/vim-fugitive",
	},
	init = function()
		vim.g.flog_enable_dynamic_commit_hl = true
		vim.g.flog_permanent_default_opts = {
			date = "relative",
			all = true,
			format = "%ad [%h] %<(6,trunc)%an%d %s",
		}
	end,
}
