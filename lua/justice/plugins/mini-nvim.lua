return {
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup({ n_lines = 1000 })
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({ n_lines = 1000 })
		end,
	},
	{
		"echasnovski/mini.diff",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.diff").setup({})

			vim.keymap.set("n", "<leader>gv", MiniDiff.toggle_overlay)
		end,
	},
	{
		"echasnovski/mini.icons",
		event = "VeryLazy",
		version = "*",
		config = function()
			local mi = require("mini.icons")
			mi.mock_nvim_web_devicons()
		end,
	},
	{
		"echasnovski/mini.files",
		version = "*",
		dependencies = {
			"folke/snacks.nvim",
		},
		init = function()
			local mf = require("mini.files")

			local show_dotfiles = true

			local filter_show = function(fs_entry)
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				mf.refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesWindowOpen",
				callback = function(args)
					local win_id = args.data.win_id
					vim.api.nvim_win_set_config(win_id, { border = "rounded" })
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "<C-h>", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files" })
					vim.keymap.set("n", "gr", mf.refresh, { buffer = buf_id, desc = "Refresh" })
					vim.keymap.set("n", "<cr>", function()
						mf.go_in({ close_on_file = true })
					end, { buffer = buf_id, desc = "Go in entry plus" })
					vim.keymap.set("n", "<C-c>", mf.close, { buffer = buf_id, desc = "Close explorer" })
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					Snacks.rename.on_rename_file(event.data.from, event.data.to)
				end,
			})
		end,
		config = function()
			local mf = require("mini.files")
			local mi = require("mini.icons")
			mf.setup({
				content = {
					prefix = function(fs_entry)
						local icon, hl = mi.get(fs_entry.fs_type, fs_entry.name)
						return icon .. " ", hl
					end,
				},
				mappings = {
					go_in = "L",
					go_in_plus = "l",
					go_out = "H",
					go_out_plus = "h",
				},
				windows = {
					width_focus = 40,
				},
			})

			local toggle_explorer = function()
				if not mf.close() then
					mf.open()
				end
			end

			local toggle_explorer_on_file = function()
				if not mf.close() then
					mf.open(vim.api.nvim_buf_get_name(0))
					mf.reveal_cwd()
				end
			end

			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>ee",
			-- 	toggle_explorer_on_file,
			-- 	{ desc = "Toggle file explorer on current file" }
			-- )
			-- vim.keymap.set("n", "<leader>ef", toggle_explorer, { desc = "Toggle file explorer" })
		end,
	},
}
