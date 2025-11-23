return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "echasnovski/mini.icons", "folke/snacks.nvim" },
	opts = {
		hooks = {
			on_rename = function(src_path, dest_path)
				Snacks.rename.on_rename_file(src_path, dest_path)
			end,
		},
		views = {
			finder = {
				win = {
					kind = "split_left_most",
					kinds = {
						split_left_most = {
							width = "35%",
							win_opts = {
								winfixwidth = true,
							},
						},
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>ee",
			"<cmd>Fyler<cr>",
			desc = "Toggle file explorer",
		},
	},
}
