return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "echasnovski/mini.icons" },
	branch = "stable",
	opts = {
		default_explorer = false,
		close_on_select = true,
		indentscope = {
			enabled = false,
		},
		views = {
			explorer = {
				width = 0.3,
				kind = "split:leftmost",
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
