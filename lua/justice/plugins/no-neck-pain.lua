return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	config = function()
		require("no-neck-pain").setup({
			width = 120,
			autocmds = {
				enableOnVimEnter = "safe",
				enableOnTabEnter = true,
			},
			buffers = {
				scratchPad = {
					enabled = true,
				},
				left = {
					scratchPad = {
						pathToFile = vim.fn.getcwd() .. "/nnp_left.md",
					},
				},
				right = {
					scratchPad = {
						pathToFile = vim.fn.getcwd() .. "/nnp_right.md",
					},
				},
			},
			mappings = {
				enabled = true,
			},
		})
	end,
}
