return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		default_explorer = false,
		close_on_select = false,
		views = {
			file_tree = {
				width = 0.25,
				kind = "split:left",
			},
		},
		mappings = {
			file_tree = {
				n = {
					["q"] = "CloseView",
					["<CR>"] = "Select",
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
