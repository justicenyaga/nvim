return {
	"letieu/wezterm-move.nvim",
	enabled = false,
	keys = {
		{
			"<C-h>",
			function()
				require("wezterm-move").move("h")
			end,
		},
		{
			"<C-j>",
			function()
				require("wezterm-move").move("j")
			end,
		},
		{
			"<C-k>",
			function()
				require("wezterm-move").move("k")
			end,
		},
		{
			"<C-l>",
			function()
				require("wezterm-move").move("l")
			end,
		},
	},
}
