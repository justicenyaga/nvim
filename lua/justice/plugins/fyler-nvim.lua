return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "echasnovski/mini.icons" },
	opts = {
		default_explorer = false,
		close_on_select = false,
		views = {
			explorer = {
				width = 0.25,
				kind = "split:left",
			},
		},
		mappings = {
			explorer = {
				n = {
					["q"] = "CloseView",
					["<CR>"] = "Select",
					["<C-CR>"] = "SelectRecursive",
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
