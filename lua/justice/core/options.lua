local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- cursor position
opt.scrolloff = 5 -- ensure that the cursor is 5 lines from top/bottom when scrolling

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "js", "ts", "jsx", "tsx", "json", "dart", "fyler" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- spell checking
-- opt.spell = true -- turn on spell checking
-- opt.spelllang = "en_us" -- sets the spell check language to English (US)

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- blinking cursor
opt.guicursor = "n-v-c:block-blinkwait300-blinkon200-blinkoff200,i-ci-ve:ver25-blinkwait300-blinkon200-blinkoff200"

-- disable auto commenting new lines
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- appearance
--- Highlight yanked (copied) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.g.nightflyTransparent = true -- make the background transparent

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Clipboard
-- opt.clipboard = "unnamedplus" -- use system clipboard as default register
-- Use clip on wsl
if vim.fn.has("wsl") == 1 and not vim.g.vscode then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end

-- Use pwsh on windows
if vim.fn.has("win32") == 1 then
	vim.o.shell = "pwsh -NoLogo"
end

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- session
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

opt.shortmess:append("IWs") -- disable intro message and search hit BOTTOM, TOP messages

-- turn off swapfile
opt.swapfile = false

-- conceal level
opt.conceallevel = 1

-- undo
vim.opt.undodir = vim.fn.expand("~/.undodir")
vim.opt.undofile = true
