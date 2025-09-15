return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "echasnovski/mini.icons", "folke/snacks.nvim" },
	opts = {
		default_explorer = false,
		close_on_select = false,
		indentscope = {
			enabled = false,
		},
		-- views = {
		-- 	explorer = {
		-- 		width = 0.3,
		-- 		kind = "split_left_most",
		-- 	},
		-- },
		hooks = {
			on_rename = function(src_path, dest_path)
				Snacks.rename.on_rename_file(src_path, dest_path)
			end,
		},
		win = {
			kind = "split_left_most",
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
