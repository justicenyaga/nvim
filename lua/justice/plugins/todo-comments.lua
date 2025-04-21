return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	optional = true,
	config = function()
		local todo_comments = require("todo-comments")

		todo_comments.setup({
			signs = false,
		})

		-- Set keymaps
		local keymap = vim.keymap

		keymap.set("n", "]t", function()
			todo_comments.jump_next()
		end, { desc = "Next todo comment" })

		keymap.set("n", "[t", function()
			todo_comments.jump_prev()
		end, { desc = "Previous todo comment" })
	end,
	keys = {
		{
			"<leader>ft",
			"<cmd>TodoQuickFix<CR>",
			desc = "Open todos on quick fix list",
		},
	},
}
