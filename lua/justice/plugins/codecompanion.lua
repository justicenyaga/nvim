return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ravitemer/codecompanion-history.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "codecompanion", "markdown" },
		},
	},
	config = function()
		require("codecompanion").setup({
			display = {
				diff = { provider = "mini_diff" },
			},
			interactions = {
				chat = { adapter = "claude_code" },
			},
			adapters = {
				http = {
					opts = { show_defaults = false },
				},
				acp = {
					extend = {
						claude_code = {
							defaults = {
								session_config_options = {
									model = "sonnet", -- or "opus"
								},
							},
						},
					},
				},
			},
			opts = { log_level = "DEBUG" },
			extensions = {
				history = {
					enabled = true,
					opts = {
						auto_save = true,
						expiration_days = 180,
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Open CodeCompanion Chat" })
		vim.keymap.set("n", "<leader>ah", "<cmd>CodeCompanionHistory<cr>", { desc = "Browse CodeCompanion History" })
	end,
}
