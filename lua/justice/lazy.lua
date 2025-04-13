local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ import = "justice.vscode_plugins" },
}

if not vim.g.vscode then
	table.insert(plugins, { import = "justice.plugins" })
	table.insert(plugins, { import = "justice.plugins.lsp" })
end

require("lazy").setup(plugins, {
	install = {
		colorscheme = { "tokyonight" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	ui = {
		size = { width = 0.75, height = 0.7 },
		border = "rounded",
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
