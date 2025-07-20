return {
	"ericrswanny/chkn.nvim",
	config = function()
		require("chkn").setup()
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
