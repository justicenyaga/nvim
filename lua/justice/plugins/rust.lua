return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		enabled = false,
		ft = "rust",
		lazy = false,
		config = function()
			local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension/")
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			local cfg = require("rustaceanvim.config")
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
						},
					},
				},
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		enabled = false,
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
}
