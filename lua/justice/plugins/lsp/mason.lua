return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"cssls",
				"clangd",
				"dockerls",
				"emmet_ls",
				"gopls",
				"graphql",
				"html",
				"lemminx",
				"lua_ls",
				"prismals",
				"pyright",
				"svelte",
				"tailwindcss",
				"ts_ls",
			},
			automatic_installation = true,
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						border = "rounded",
						height = 0.8,
						width = 0.7,
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			{
				"neovim/nvim-lspconfig",
				config = function() end,
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"black", -- python formatter
				"clang-format", -- c/cpp formatter
				"eslint_d", -- js linter
				"gofumpt", -- Go formatter
				"goimports", -- Go formatter
				"golangci-lint", -- Go linter
				"golines", -- Go formatter
				"isort", -- python formatter
				"kulala-fmt", -- http formatter
				"prettier", -- prettier formatter
				"pylint", -- python linter
				"stylua", -- lua formatter
			},
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"codelldb", -- Rust debugger
				"delve", -- Go debugger
			},
		},
	},
}
