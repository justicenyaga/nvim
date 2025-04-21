return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		if vim.fn.has("wsl") == 1 then
			vim.g.mkdp_browser = "chrome"
		elseif vim.fn.has("win32") then
			vim.g.mkdp_browser = "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
		else
			vim.g.mkdp_browser = "google-chrome-stable"
		end
	end,
	keys = {
		{
			"<leader>mp",
			":MarkdownPreviewToggle<cr>",
			desc = "Toggle markdown preview",
		},
	},
}
