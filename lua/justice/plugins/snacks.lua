---@diagnostic disable: undefined-global
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		return {
			bigfile = { enabled = true },
			quickfile = { enabled = false },
			dashboard = { enabled = true },
			words = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true, style = "fancy" },
			picker = {
				enabled = true,
				formatters = {
					file = {
						-- filename_first = true,
					},
				},
				win = {
					input = {
						keys = {
							["<Esc>"] = { "close", mode = { "n", "i" } },
							["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
							["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<C-v>"] = { "edit_vsplit", mode = { "i", "n" } },
							["<C-h>"] = { "edit_split", mode = { "i", "n" } },
						},
					},
					list = {
						keys = {
							["<C-v>"] = "edit_vsplit",
							["<C-h>"] = "edit_split",
							["<C-d>"] = "preview_scroll_down",
							["<C-u>"] = "preview_scroll_up",
						},
					},
				},
			},
			statuscolumn = {
				enabled = true,
				folds = { open = true },
				right = { "git", "fold" },
			},
			styles = {
				input = {
					relative = "cursor",
					row = 1,
					col = 0,
					width = 40,
				},
			},
		}
	end,
	keys = {
		{
			"<c-t>",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle terminal",
			mode = { "n", "t" },
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit current file history",
		},
		-- {
		-- 	"<leader>gg",
		-- 	function()
		-- 		Snacks.lazygit.log()
		-- 	end,
		-- 	desc = "Lazygit log",
		-- },
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git browse",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Open lazygit",
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart find files",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files({ hidden = true, follow = true })
			end,
			desc = "Find files in cwd",
		},
		{
			"<leader>f.",
			function()
				Snacks.picker.recent()
			end,
			desc = "Find recent files",
		},
		{
			"<leader>f/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep in cwd",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep word under cursor",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Find document symbols",
		},
		{
			"<leader>fS",
			function()
				Snacks.picker.lsp_workspace_symbols({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Find workspace symbols",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>fB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep open buffers",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Find keymaps",
		},
		{
			"<leader>fC",
			function()
				Snacks.picker.colorschemes({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Colorscheme",
		},
		{
			"<leader>fn",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find nvim config files",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.files({ dirs = { "~/obsidian/notes", "~/obsidian/inbox" }, hidden = true, follow = true })
			end,
			desc = "Find obsidian notes",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Find todos",
		},
		{
			"<leader>nh",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Show notifications history",
		},
		{
			"gf",
			function()
				Snacks.picker.lsp_references({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Show lsp references",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Go to declaration",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Go to definition",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Go to implementation",
		},
		{
			"gt",
			function()
				Snacks.picker.lsp_type_definitions({ layout = { preset = "vscode", preview = "main" } })
			end,
			desc = "Go to type definition",
		},
		{
			"<leader>uu",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		-- {
		-- 	"<leader>.",
		-- 	function()
		-- 		Snacks.scratch()
		-- 	end,
		-- 	desc = "Toggle Scratch Buffer",
		-- },
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev reference",
			mode = { "n", "t" },
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Create some toggle mappings
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ul")
				Snacks.toggle.treesitter():map("<leader>ut")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
			end,
		})
	end,
}
