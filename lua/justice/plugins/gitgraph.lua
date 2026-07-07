return {
	"isakbm/gitgraph.nvim",
	opts = {
		symbols = {
			merge_commit = "",
			commit = "",
			merge_commit_end = "",
			commit_end = "",
			GVER = "",
			GHOR = "",
			GCLD = "",
			GCRD = "╭",
			GCLU = "",
			GCRU = "",
			GLRU = "",
			GLRD = "",
			GLUD = "",
			GRUD = "",
			GFORKU = "",
			GFORKD = "",
			GRUDCD = "",
			GRUDCU = "",
			GLUDCD = "",
			GLUDCU = "",
			GLRDCL = "",
			GLRDCR = "",
			GLRUCL = "",
			GLRUCR = "",
		},
	},
	keys = {
		{
			"<leader>gg",
			function()
				local current_tab = vim.api.nvim_get_current_tabpage()
				local target_tab = nil

				for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
					for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
						local buf = vim.api.nvim_win_get_buf(win)
						if vim.bo[buf].filetype == "gitgraph" then
							target_tab = tab
							break
						end
					end
					if target_tab then
						break
					end
				end

				if target_tab then
					if target_tab == current_tab then
						vim.cmd("tabclose")
					else
						local tab_nr = vim.api.nvim_tabpage_get_number(target_tab)
						vim.cmd(tab_nr .. "tabnext")
					end
				else
					vim.cmd("tabnew")
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end
			end,
			desc = "GitGraph - Toggle",
		},
	},
}
