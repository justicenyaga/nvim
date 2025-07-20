return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "codecompanion", "markdown" },
		},
	},
	config = function()
		require("codecompanion").setup({
			display = {
				diff = {
					provider = "mini_diff",
				},
			},
			strategies = {
				chat = {
					adapter = "gemini",
				},
				inline = {
					adapter = "deepseekr1",
				},
			},
			opts = { log_level = "DEBUG" },
			adapters = {
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						env = {
							api_key = "MY_ANTHROPIC_KEY",
						},
					})
				end,
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = {
							api_key = "GEMINI_API_KEY",
						},
						name = "gemini",
						schema = {
							model = { default = "gemini-2.5-flash" },
							max_tokens = { default = 2048 },
							reasoning_effort = { default = "none" },
						},
					})
				end,
				deepseekv3 = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = "OPENROUTER_API_KEY",
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "deepseek/deepseek-chat",
							},
						},
					})
				end,
				deepseekr1 = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = "OPENROUTER_API_KEY",
							chat_url = "/v1/chat/completions",
						},
						opts = {
							stream = false,
							can_reason = true,
						},
						schema = {
							model = {
								default = "deepseek/deepseek-r1",
							},
						},
						handlers = {
							chat_output = function(self, data)
								local utils = require("codecompanion.utils.adapters")
								local output = {}

								if data and data ~= "" then
									local data_mod = utils.clean_streamed_data(data)
									local ok, json = pcall(vim.json.decode, data_mod, { luanil = { object = true } })

									if ok and json.choices and #json.choices > 0 then
										local choice = json.choices[1]
										local delta = (self.opts and self.opts.stream) and choice.delta
											or choice.message

										if delta then
											output.role = nil
											if delta.role then
												output.role = delta.role
											end
											if self.opts.can_reason and delta.reasoning then
												output.reasoning = delta.reasoning
											end
											if delta.content then
												output.content = (output.content or "") .. delta.content
											end
											return {
												status = "success",
												output = output,
											}
										end
									end
								end
							end,
						},
					})
				end,
			},
		})

		vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat<cr>", { desc = "Open CodeCompanion Chat" })
	end,
}
