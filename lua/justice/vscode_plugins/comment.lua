return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			-- for commenting tsx and jsx files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})

		local toggle = require("Comment.api").toggle

		vim.keymap.set("n", "<leader>cc", function()
			vim.cmd("normal! yy")
			vim.cmd("normal! P")
			toggle.linewise.current()
			vim.cmd("normal! j")
		end, { noremap = true, silent = true, desc = "Copy, Comment and Paste current line" })
		vim.keymap.set("v", "<leader>cc", function()
			vim.cmd("normal! yy")
			vim.cmd("normal! `>p")
			vim.cmd("normal! gv")
			toggle.linewise(vim.fn.visualmode())
		end, { noremap = true, silent = true, desc = "Copy, Comment and Paste current line" })
	end,
}
