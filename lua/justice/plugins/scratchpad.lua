return {
	"ericrswanny/chkn.nvim",
	config = function()
		require("chkn").setup({
			width = 120,
			height = 40,
		})
	end,
	lazy = false,
	keys = {
		{
			"<leader>.",
			function()
				vim.cmd("silent! ChknToggle")
			end,
			desc = "Toggle Scratchpad",
		},
	},
}
