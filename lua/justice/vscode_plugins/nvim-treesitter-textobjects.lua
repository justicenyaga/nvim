return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = { lookahead = true },
			move = { set_jumps = true },
		})

		-- Select keymaps
		local select = require("nvim-treesitter-textobjects.select")
		local function map_select(lhs, query, desc)
			vim.keymap.set({ "x", "o" }, lhs, function()
				select.select_textobject(query, "textobjects")
			end, { desc = desc })
		end

		map_select("a=", "@assignment.outer", "Select outer assignment")
		map_select("i=", "@assignment.inner", "Select inner assignment")
		map_select("l=", "@assignment.lhs", "Select lhs of assignment")
		map_select("r=", "@assignment.rhs", "Select rhs of assignment")
		map_select("a:", "@property.outer", "Select outer object property")
		map_select("i:", "@property.inner", "Select inner object property")
		map_select("l:", "@property.lhs", "Select left of object property")
		map_select("r:", "@property.rhs", "Select right of object property")
		map_select("aa", "@parameter.outer", "Select outer parameter/argument")
		map_select("ia", "@parameter.inner", "Select inner parameter/argument")
		map_select("ai", "@conditional.outer", "Select outer conditional")
		map_select("ii", "@conditional.inner", "Select inner conditional")
		map_select("al", "@loop.outer", "Select outer loop")
		map_select("il", "@loop.inner", "Select inner loop")
		map_select("af", "@call.outer", "Select outer function call")
		map_select("if", "@call.inner", "Select inner function call")
		map_select("am", "@function.outer", "Select outer method/function def")
		map_select("im", "@function.inner", "Select inner method/function def")
		map_select("ac", "@class.outer", "Select outer class")
		map_select("ic", "@class.inner", "Select inner class")

		-- Swap keymaps
		local swap = require("nvim-treesitter-textobjects.swap")
		vim.keymap.set("n", "<leader>na", function()
			swap.swap_next("@parameter.inner", "textobjects")
		end, { desc = "Swap parameter with next" })
		vim.keymap.set("n", "<leader>n:", function()
			swap.swap_next("@property.outer", "textobjects")
		end, { desc = "Swap property with next" })
		vim.keymap.set("n", "<leader>nm", function()
			swap.swap_next("@function.outer", "textobjects")
		end, { desc = "Swap function with next" })
		vim.keymap.set("n", "<leader>pa", function()
			swap.swap_previous("@parameter.inner", "textobjects")
		end, { desc = "Swap parameter with prev" })
		vim.keymap.set("n", "<leader>p:", function()
			swap.swap_previous("@property.outer", "textobjects")
		end, { desc = "Swap property with prev" })
		vim.keymap.set("n", "<leader>pm", function()
			swap.swap_previous("@function.outer", "textobjects")
		end, { desc = "Swap function with prev" })

		-- Move keymaps
		local move = require("nvim-treesitter-textobjects.move")
		local function map_move(lhs, fn, query, desc)
			vim.keymap.set({ "n", "x", "o" }, lhs, function()
				move[fn](query, "textobjects")
			end, { desc = desc })
		end

		map_move("]f", "goto_next_start", "@call.outer", "Next function call start")
		map_move("]m", "goto_next_start", "@function.outer", "Next method/function def start")
		map_move("]c", "goto_next_start", "@class.outer", "Next class start")
		map_move("]i", "goto_next_start", "@conditional.outer", "Next conditional start")
		map_move("]l", "goto_next_start", "@loop.outer", "Next loop start")
		map_move("]F", "goto_next_end", "@call.outer", "Next function call end")
		map_move("]M", "goto_next_end", "@function.outer", "Next method/function def end")
		map_move("]C", "goto_next_end", "@class.outer", "Next class end")
		map_move("]I", "goto_next_end", "@conditional.outer", "Next conditional end")
		map_move("]L", "goto_next_end", "@loop.outer", "Next loop end")
		map_move("[f", "goto_previous_start", "@call.outer", "Prev function call start")
		map_move("[m", "goto_previous_start", "@function.outer", "Prev method/function def start")
		map_move("[c", "goto_previous_start", "@class.outer", "Prev class start")
		map_move("[i", "goto_previous_start", "@conditional.outer", "Prev conditional start")
		map_move("[l", "goto_previous_start", "@loop.outer", "Prev loop start")
		map_move("[F", "goto_previous_end", "@call.outer", "Prev function call end")
		map_move("[M", "goto_previous_end", "@function.outer", "Prev method/function def end")
		map_move("[C", "goto_previous_end", "@class.outer", "Prev class end")
		map_move("[I", "goto_previous_end", "@conditional.outer", "Prev conditional end")
		map_move("[L", "goto_previous_end", "@loop.outer", "Prev loop end")

		-- Scope / fold jumps use a different query group
		vim.keymap.set({ "n", "x", "o" }, "]s", function()
			move.goto_next_start("@local.scope", "locals")
		end, { desc = "Next scope" })
		vim.keymap.set({ "n", "x", "o" }, "]z", function()
			move.goto_next_start("@fold", "folds")
		end, { desc = "Next fold" })

		-- Repeatable f/F/t/T
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
