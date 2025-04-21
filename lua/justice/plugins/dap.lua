return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			opt = {},
			build = "npm i --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
	},
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import nvim-dap plugin
		local dap = require("dap")

		-- import nvim-dap-ui plugin
		local dapui = require("dapui")

		local keymap = vim.keymap -- for conciseness

		dap.set_log_level("INFO") -- Helps when configuring DAP, see logs with :DapShowLog

		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		-- seutp dap-virtual-text
		require("nvim-dap-virtual-text").setup()

		dap.configurations = {
			go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
			},
			java = {
				{
					type = "java",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
			},
		}

		for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch Current File (pwa-node)",
					cwd = vim.fn.getcwd(),
					args = { "${file}" },
					sourceMaps = true,
					protocol = "inspector",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch Current File (pwa-node with ts-node)",
					cwd = vim.fn.getcwd(),
					runtimeArgs = { "--loader", "ts-node/esm" },
					runtimeExecutable = "node",
					args = { "${file}" },
					sourceMaps = true,
					protocol = "inspector",
					skipFiles = { "<node_internals>/**", "node_modules/**" },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch Current File (pwa-node with jest)",
					cwd = vim.fn.getcwd(),
					runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
					runtimeExecutable = "node",
					args = { "${file}", "--coverage", "false" },
					rootPath = "${workspaceFolder}",
					sourceMaps = true,
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					skipFiles = { "<node_internals>/**", "node_modules/**" },
				},
				{
					type = "pwa-chrome",
					request = "attach",
					name = "Attach Program (pwa-chrome = { port: 9222 })",
					program = "${file}",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					port = 9222,
					webRoot = "${workspaceFolder}",
				},
				{
					type = "node2",
					request = "attach",
					name = "Attach Program (Node2)",
					processId = require("dap.utils").pick_process,
				},
				{
					type = "node2",
					request = "attach",
					name = "Attach Program (Node2 with ts-node)",
					cwd = vim.fn.getcwd(),
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					port = 9229,
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach program (pwa-node)",
					cwd = vim.fn.getcwd(),
					processId = require("dap.utils").pick_process,
					skipFiles = { "<node_internals>/**" },
				},
			}
		end

		dap.adapters.go = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

		keymap.set("n", "<leader>bc", dap.continue, { desc = "Continue" })
		keymap.set("n", "<leader>bk", function()
			dapui.eval(nil, { enter = true })
		end)
		keymap.set("n", "<leader>bo", dap.step_over, { desc = "Step Over" })
		keymap.set("n", "<leader>bi", dap.step_into, { desc = "Step into" })
		keymap.set("n", "<leader>bO", dap.step_out, { desc = "Step Out" })
		keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Toggle Breakpoint on a Line" })
		keymap.set("n", "<leader>bB", function()
			dap.clear_breakpoints()
			vim.notify("Breakpoints cleared", vim.log.levels.INFO)
		end, { desc = "Clear all Breakpoints" })

		-- Close debugger and clear breakpoints
		keymap.set("n", "<leader>bq", function()
			dap.clear_breakpoints()
			dap.terminate()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) --
			vim.notify("Debug session ended", vim.log.levels.WARN)
		end, { desc = "Close debugger and end debugging session" })

		dapui.setup({
			expand_lines = vim.fn.has("nvim-0.7"),
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.25,
						},
						{
							id = "watches",
							size = 0.25,
						},
						{
							id = "stacks",
							size = 0.25,
						},
						{
							id = "breakpoints",
							size = 0.25,
						},
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					size = 10,
					position = "bottom",
				},
			},
			floating = {
				border = "rounded",
			},
		})
	end,
}
