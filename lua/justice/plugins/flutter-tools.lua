return {
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/snacks.nvim",
		},
		config = function()
			local util = require("justice.functions.util")

			local flutter_path = nil
			local analysisExcludedFolders = {
				".dart_tool",
				"build",
				"ios",
				"android",
				".idea",
				".vscode",
				"test",
				".git",
			}

			if vim.fn.has("win32") == 1 then
				table.insert(analysisExcludedFolders, vim.fn.expand("$HOME/AppData/Local/Pub/Cache"))
			else
				table.insert(analysisExcludedFolders, vim.fn.expand("$HOME/.pub-cache"))
			end

			require("flutter-tools").setup({
				flutter_path = flutter_path,
				fvm = true,
				ui = {
					border = "rounded",
					notification_style = "plugin",
				},
				decorations = {
					statusline = {
						app_version = true,
						device = true,
						project_config = true,
					},
				},
				root_patterns = { "pubspec.yaml" },
				outline = {
					open_cmd = "45vnew",
					auto_open = false,
				},
				closing_tags = {
					enabled = true,
					highlight = "Comment",
					prefix = "󰜬 ",
				},
				dev_log = {
					open_cmd = "tabedit",
				},
				lsp = {
					capabilities = util.get_lsp_capabilities(),
					on_attach = util.lsp_on_attach,
					settings = {
						showTodos = true,
						completeFunctionCalls = true,
						renameFilesWithClasses = "prompt",
						enableSnippets = true,
						enableSdkFormatter = true,
						analysisExcludedFolders = analysisExcludedFolders,
						updateImportsOnRename = true,
					},
				},
				debugger = {
					enabled = false,
				},
			})

			vim.keymap.set("n", "<leader>df", function()
				local flutter_commands = util.get_flutter_commands().flutter_commands
				local items
				if vim.fn.expand("%:t") == "pubspec.yaml" then
					items = util.get_flutter_commands().pubspec_commands
					for _, item in ipairs(flutter_commands) do
						table.insert(items, item)
					end
				else
					items = flutter_commands
				end

				require("snacks.picker")({
					title = "Flutter Tools Commands",
					items = items,
					layout = {
						preview = false,
						preset = "select",
						layout = { height = 0.5 },
					},

					confirm = function(ctx, item)
						if item.execute then
							vim.defer_fn(item.execute, 50)
							ctx:close()
						end
						return true
					end,
				})
			end)

			vim.keymap.set("n", "<leader>dd", ":FlutterDevices<cr>", { desc = "Show available flutter devices" })
			vim.keymap.set("n", "<leader>dl", ":FlutterLogToggle<cr>", { desc = "Toggle flutter dev log" })
			vim.keymap.set("n", "<leader>dL", ":FlutterLogClear<cr>", { desc = "Clear flutter dev log" })
			vim.keymap.set("n", "<leader>dr", ":FlutterRestart<cr>", { desc = "Restart running flutter project" })
			vim.keymap.set(
				"n",
				"<leader>do",
				":FlutterOutlineToggle<cr>",
				{ desc = "Toggle current flutter file widget tree" }
			)
			vim.keymap.set("n", "<leader>dq", ":FlutterQuit<cr>", { desc = "End running flutter session" })

			-- Check if pubspec.yaml exists in the current directory
			local pubspec_path = vim.fn.getcwd() .. "/pubspec.yaml"
			local file_exists = vim.fn.filereadable(pubspec_path) == 1

			-- Add keymap only if the file exists
			if file_exists then
				vim.keymap.set("n", "<leader>dp", "<cmd>e pubspec.yaml<cr>", { desc = "Open pubspec.yaml" })
				vim.keymap.set("n", "<leader>dg", "<cmd>FlutterPubGet<cr>", { desc = "Get dependencies" })
				vim.keymap.set("n", "<leader>du", "<cmd>FlutterPubUpgrade<cr>", { desc = "Upgrade dependencies" })
			end

			vim.api.nvim_create_autocmd("BufReadPost", {
				pattern = "pubspec.yaml",
				callback = function()
					vim.keymap.set(
						"n",
						"<leader>da",
						":PubspecAssistAddPackage<cr>",
						{ desc = "Add flutter dependency" }
					)
					vim.keymap.set(
						"n",
						"<leader>dA",
						":PubspecAssistAddDevPackage<cr>",
						{ desc = "Add flutter dev dependency" }
					)
					vim.keymap.set(
						"n",
						"<leader>dv",
						":PubspecAssistPickVersion<cr>",
						{ desc = "Change flutter dependency version" }
					)
				end,
			})
		end,
	},
	{
		-- "nvim-flutter/pubspec-assist.nvim",
		"justicenyaga/pubspec-assist.nvim",
		branch = "fix/add-dependencies-windows",
		event = "BufReadPost pubspec.yaml",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("pubspec-assist").setup()
		end,
	},
	{
		"wa11breaker/flutter-bloc.nvim",
		dependencies = "nvimtools/none-ls.nvim",
		ft = "dart",
		opts = {
			block_type = "default",
			use_sealed_classes = false,
			enable_code_actions = true,
		},
		keys = {
			{
				"<leader>dc",
				"<cmd>FlutterCreateCubit<cr>",
				desc = "Create a Cubit",
			},
			{
				"<leader>dC",
				"<cmd>FlutterCreateBloc<cr>",
				desc = "Create a Bloc",
			},
		},
	},
	{
		"wa11breaker/dart-data-class-generator.nvim",
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
		ft = "dart",
		config = function()
			require("dart-data-class-generator").setup({})
		end,
	},
}
