return {
	"mechatroner/rainbow_csv",
	ft = "csv",
	init = function()
		vim.g.disable_rainbow_hover = 1
		vim.g.rcsv_max_columns = 50
		vim.g.rbql_with_headers = 1
	end,
	keys = {
		{
			"<leader>qr",
			"<cmd>RainbowQuery<CR>",
			desc = "Run rainbow query",
		},
		{
			"<leader>qa",
			"<cmd>RainbowAlign<CR>",
			desc = "Align columns",
		},
	},
}
