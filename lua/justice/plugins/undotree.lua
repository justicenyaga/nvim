return {
	"jiaoshijie/undotree",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("undotree").setup({
			float_diff = true,
			layout = "left_bottom",
			position = "left",
			ignore_filetype = {
				"undotree",
				"undotreeDiff",
				"qf",
				"snacks_input",
				"snacks_picker_list",
				"snacks_picker_input",
			},
			window = {
				winblend = 0,
			},
		})

		vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
	end,
}
