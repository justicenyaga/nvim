local api = vim.api
local flutter_commands = require("justice.functions.flutter_commands_list")

local function press_enter()
	api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true)
end

local function string_starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

local function basename(str)
	return string.match(str, "^.+/(.+)$")
end

local function get_branch_name()
	local is_git_branch = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null"):read("*a")
	if is_git_branch == "true\n" then
		for line in io.popen("git branch 2>/dev/null"):lines() do
			local current_branch = line:match("%* (.+)$")
			if current_branch then
				return current_branch
			end
		end
	end
end

local function branch_exists(branch)
	local is_git_branch = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null"):read("*a")
	if is_git_branch == "true\n" then
		for line in io.popen("git branch 2>/dev/null"):lines() do
			line = line:gsub("%s+", "")
			if line == branch then
				return true
			end
		end
	end
	return false
end

local function get_tab_by_buf_name(name, starts_with)
	for _, tab in ipairs(api.nvim_list_tabpages()) do
		local wins = api.nvim_tabpage_list_wins(tab)
		for _, win in ipairs(wins) do
			local buf = api.nvim_win_get_buf(win)
			local buf_name = api.nvim_buf_get_name(buf)
			if starts_with then
				if string_starts(buf_name, name) then
					return tab
				end
			else
				local base_name = basename(buf_name)
				if base_name == name then
					return tab
				end
			end
		end
	end
	return -1
end

local function open_in_tab(buf_name, starts_with, open_fn)
	local tab = get_tab_by_buf_name(buf_name, starts_with)
	if tab ~= -1 then
		api.nvim_set_current_tabpage(tab)
	else
		open_fn()
	end
end

local function get_lsp_capabilities()
	return require("blink.cmp").get_lsp_capabilities()
end

local function lsp_on_attach(_, bufnr)
	local opts = { noremap = true, silent = true }
	opts.buffer = bufnr

	-- set keybinds
	opts.desc = "See available code actions"
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

	opts.desc = "Rename"
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

	opts.desc = "Show documentation for what is under cursor"
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover({ border = "rounded" })
	end, opts) -- show documentation for what is under cursor
end

local function get_flutter_commands()
	return flutter_commands
end

return {
	basename = basename,
	branch_exists = branch_exists,
	get_branch_name = get_branch_name,
	get_tab_by_buf_name = get_tab_by_buf_name,
	press_enter = press_enter,
	string_starts = string_starts,
	open_in_tab = open_in_tab,
	get_lsp_capabilities = get_lsp_capabilities,
	lsp_on_attach = lsp_on_attach,
	get_flutter_commands = get_flutter_commands,
}
