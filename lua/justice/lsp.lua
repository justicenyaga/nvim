local keymap = vim.keymap

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts) -- show documentation for what is under cursor

		opts.desc = "Float next diagnostic"
		keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end,
})

local severity = vim.diagnostic.severity
vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_text = true,
	-- virtual_lines = { current_line = true },
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.INFO] = "󰋼 ",
			[severity.HINT] = "󰌵 ",
		},
	},
})
