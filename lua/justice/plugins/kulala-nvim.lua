vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		ui = {
			win_opts = {
				width = 100,
			},
			default_view = function()
				vim.treesitter.stop()
				require("kulala.ui").show_body()
			end,
		},
		global_keymaps = false,
	},
	keys = {
		{
			"<leader>rb",
			function()
				require("kulala").scratchpad()
			end,
			desc = "Open scratchpad",
		},
		{
			"<leader>ca",
			vim.lsp.buf.code_action,
			desc = "Rest code actions",
		},
		{
			"<leader>ro",
			function()
				require("kulala").open()
			end,
			desc = "Open kulala",
		},
		{
			"<leader>rt",
			function()
				require("kulala").toggle_view()
			end,
			ft = { "http", "rest" },
			desc = "Toggle request headers/body",
		},
		{
			"<leader>rs",
			function()
				require("kulala").show_stats()
			end,
			ft = { "http", "rest" },
			desc = "Show stats",
		},
		{
			"<leader>rq",
			function()
				require("kulala").close()
			end,
			ft = { "http", "rest" },
			desc = "Close window",
		},

		{
			"<leader>rc",
			function()
				require("kulala").copy()
			end,
			ft = { "http", "rest" },
			desc = "Copy as cURL",
		},
		{
			"<leader>rC",
			function()
				require("kulala").from_curl()
			end,
			ft = { "http", "rest" },
			desc = "Paste from curl",
		},
		{
			"<leader>rr",
			function()
				require("kulala").run()
			end,
			mode = { "n", "v" },
			desc = "Send request",
		},
		{
			"<leader>ra",
			function()
				require("kulala").run_all()
			end,
			mode = { "n", "v" },
			desc = "Send all requests",
		},
		{
			"<leader>ri",
			function()
				require("kulala").inspect()
			end,
			ft = { "http", "rest" },
			desc = "Inspect current request",
		},
		{
			"<leader>rl",
			function()
				require("kulala").replay()
			end,
			desc = "Replay the last request",
		},

		{
			"<leader>rf",
			function()
				-- require("kulala").search()
				Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
			end,
			ft = { "http", "rest" },
			desc = "Find request",
		},
		{
			"]r",
			function()
				require("kulala").jump_next()
			end,
			ft = { "http", "rest" },
			desc = "Jump to next request",
		},
		{
			"[r",
			function()
				require("kulala").jump_prev()
			end,
			ft = { "http", "rest" },
			desc = "Jump to previous request",
		},
		{
			"<leader>re",
			function()
				require("kulala").set_selected_env()
			end,
			ft = { "http", "rest" },
			desc = "Select environment",
		},
		{
			"<leader>ru",
			function()
				require("lua.kulala.ui.auth_manager").open_auth_config()
			end,
			ft = { "http", "rest" },
			desc = "Manage Auth Config",
		},
		{
			"<leader>rg",
			function()
				require("kulala").download_graphql_schema()
			end,
			ft = { "http", "rest" },
			desc = "Download GraphQL schema",
		},
		{
			"<leader>rx",
			function()
				require("kulala").scripts_clear_global()
			end,
			ft = { "http", "rest" },
			desc = "Clear globals",
		},
		{
			"<leader>rX",
			function()
				require("kulala").clear_cached_files()
			end,
			ft = { "http", "rest" },
			desc = "Clear cached files",
		},
	},
}
