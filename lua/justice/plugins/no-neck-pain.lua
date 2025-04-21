return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	config = function()
		require("no-neck-pain").setup({
			width = 125,
			autocmds = {
				enableOnVimEnter = "safe",
				enableOnTabEnter = true,
			},
			mappings = { enabled = true },
		})
	end,
}
