return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			suppress_dirs = { "~/", "~/Desktop", "~/Documents", "~/Downloads", "~/projects" },
		})

		vim.keymap.set("n", "<leader>wr", ":SessionRestore<CR>", { desc = "Restore session for cwd" })
		vim.keymap.set("n", "<leader>ws", ":SessionSave<CR>", { desc = "Save session" })
		vim.keymap.set("n", "<leader>wf", ":Autosession search<CR>", { desc = "Open a session picker" })
		vim.keymap.set("n", "<leader>wd", ":Autosession delete<CR>", { desc = "Open a session picker" })
	end,
}
