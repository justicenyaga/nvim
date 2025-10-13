return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"rust-lang/rust.vim",
			ft = "rust",
			init = function()
				vim.g.rustfmt_autosave = 1
			end,
		},
	},
	config = function()
		local conform = require("conform")

		-- Create a variable to track the format-on-save state
		local format_on_save_enabled = true

		conform.setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				go = { "goimports", "gofumpt" },
				graphql = { "prettier" },
				html = { "prettier" },
				http = { "kulala" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				python = { "isort", "black" },
				svelte = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				yaml = { "prettier" },
			},
			formatters = {
				prettier = {
					args = function(self, ctx)
						if vim.endswith(ctx.filename, ".ejs") then
							return { "--stdin-filepath", "$FILENAME", "--parser", "html" }
						end
						return { "--stdin-filepath", "$FILENAME" }
					end,
					range_args = function(self, ctx, range)
						if vim.endswith(ctx.filename, ".ejs") then
							return { "--stdin-filepath", "$FILENAME", "--parser", "html", "--range", range }
						end
						return { "--stdin-filepath", "$FILENAME", "--range", range }
					end,
				},
				kulala = {
					command = "kulala-fmt",
					args = { "format", "$FILENAME" },
					stdin = false,
				},
			},
			format_on_save = function()
				if not format_on_save_enabled or vim.bo.filetype == "java" then
					return
				else
					return {
						lsp_format = "fallback",
						async = false,
						timeout_ms = 3000,
					}
				end
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 3000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Add keymap to toggle format-on-save
		vim.keymap.set("n", "<leader>uf", function()
			format_on_save_enabled = not format_on_save_enabled
			if format_on_save_enabled then
				vim.notify("Enabled Format On Save", vim.log.levels.INFO)
			else
				vim.notify("Disabled Format On Save", vim.log.levels.WARN)
			end
		end, { desc = "Toggle format on save" })
	end,
}
