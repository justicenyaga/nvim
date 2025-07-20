return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	config = function()
		local set_hl = vim.api.nvim_set_hl

		local highlight = {
			"RainbowYellow",
			"RainbowBlue",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			set_hl(0, "RainbowYellow", { fg = "#FFD77B" })
			set_hl(0, "RainbowBlue", { fg = "#82CFFF" })
			set_hl(0, "RainbowGreen", { fg = "#B4E88D" })
			set_hl(0, "RainbowViolet", { fg = "#D291FF" })
			set_hl(0, "RainbowCyan", { fg = "#76E4E8" })
		end)

		require("ibl").setup({
			indent = {
				char = "│",

				smart_indent_cap = false,
			},
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
				highlight = highlight,
			},
		})

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
