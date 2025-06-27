-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap.set -- for conciseness

---------------------
-- General Keymaps -------------------

-- clear search highlights
keymap("n", "<ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- Select All
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

-- Horizontal scroll
keymap("n", "<left>", "zH", { desc = "Scroll left" })
keymap("n", "<right>", "zL", { desc = "Scroll right" })

-- increment/decrement numbers
keymap("n", "+", "<C-a>", { desc = "Increment number" }) -- increment
keymap("n", "-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Find and Replace Keymap
keymap("n", "<leader>fr", ":%s//gc<Left><Left><Left>", { desc = "Find and Replace" })
keymap("n", "<leader>fR", ":%s/<C-r><C-w>//gc<Left><Left><Left>", { desc = "Find and replace word under cursor" })

-- System clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap({ "n", "v" }, "<leader>d", '"+d', { desc = "Cut to system clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard (before cursor)" })

if vim.g.vscode then
	require("justice.core.vscode_keymaps")
else
	require("justice.core.native_keymaps")
end
