return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
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
			"<cmd>TodoQuickFix<cr>",
			desc = "Open todos on quickfix list",
		},
	},
}
