local trigger_text = ";"

return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "VeryLazy",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.compat",
		"onsails/lspkind.nvim",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		{
			"r5n-labs/vscode-react-javascript-snippets",
			build = "yarn install --frozen-lockfile && yarn compile",
		},
	},
	config = function()
		local luasnip = require("luasnip")

		-- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Add lorem ipsum snippets to all file types
		luasnip.filetype_extend("all", { "loremipsum" })
		luasnip.filetype_extend("dart", { "flutter" })

		vim.api.nvim_set_hl(0, "BlinkCmpKindCodeium", { fg = "#21d4fd" })

		require("blink-cmp").setup({
			enabled = function()
				local disabled_filetypes =
					{ "snacks_input", "snacks_picker_list", "snacks_picker_input", "gitcommit", "minifiles" }
				return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
			end,
			snippets = {
				preset = "luasnip",
				expand = function(snippets)
					luasnip.lsp_expand(snippets)
				end,
				active = function(filter)
					if filter and filter.direction then
						return luasnip.jumpable(filter.direction)
					end
					return luasnip.in_snippet()
				end,
				jump = function(direction)
					luasnip.jump(direction)
				end,
			},
			cmdline = {
				keymap = { preset = "inherit" },
				completion = {
					ghost_text = { enabled = false },
				},
			},
			sources = {
				default = {
					"codeium",
					"obsidian",
					"obsidian_new",
					"obsidian_tags",
					"lsp",
					"snippets",
					"buffer",
					"path",
				},
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
					codeium = {
						name = "Codeium",
						module = "codeium.blink",
						enabled = false,
						async = true,
						transform_items = function(_, items)
							for _, item in ipairs(items) do
								item.kind_icon = "󱃖"
								item.kind_name = "Codeium"
							end
							return items
						end,
					},
					snippets = {
						name = "snippets",
						score_offset = 100,
						should_show_items = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							return before_cursor:match(trigger_text .. "%w*$") ~= nil
						end,
						transform_items = function(_, items)
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
							if trigger_pos then
								for _, item in ipairs(items) do
									if not item.trigger_text_modified then
										item.trigger_text_modified = true
										item.textEdit = {
											newText = item.insertText or item.label,
											range = {
												start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
												["end"] = { line = vim.fn.line(".") - 1, character = col },
											},
										}
									end
								end
							end
							return items
						end,
					},
					obsidian = {
						name = "obsidian",
						module = "blink.compat.source",
					},
					obsidian_new = {
						name = "obsidian_new",
						module = "blink.compat.source",
					},
					obsidian_tags = {
						name = "obsidian_tags",
						module = "blink.compat.source",
					},
				},
			},
			signature = {
				enabled = false,
				window = { treesitter_highlighting = false },
			},
			completion = {
				list = {
					selection = { auto_insert = false },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 20,
					window = { border = "rounded" },
				},
				accept = { auto_brackets = { enabled = true } },
				menu = {
					draw = {
						align_to = "cursor",
						treesitter = { "lsp" },
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr ~= "" then
											icon = color_item.abbr
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									if ctx.item.source_name == "Codeium" then
										return {
											{ group = "BlinkCmpKindCodeium", priority = 20000 },
										}
									elseif ctx.item.source_name == "LSP" then
										local highlight = "BlinkCmpKind" .. ctx.kind
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
										return highlight
									else
										return {
											{ group = ctx.kind_hl, priority = 20000 },
										}
									end
								end,
							},
						},
					},
				},
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
				kind_icons = {
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Struct = "󰙅",
					Value = "󰎠",
					Enum = "",
					EnumMember = "",
					Keyword = "󰌋",
					Constant = "󰏿",
					Reference = "󰈇",
					Operator = "󰆕",
				},
			},
			keymap = {
				preset = "default",
				["<C-n>"] = { "snippet_forward", "fallback" },
				["<C-p>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },

				["<C-c>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
			},
		})
	end,
	opts_extend = { "sources.default" },
}
