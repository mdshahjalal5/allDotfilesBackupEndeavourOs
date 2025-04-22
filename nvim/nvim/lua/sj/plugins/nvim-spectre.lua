return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local spectre = require("spectre")

		spectre.setup({
			highlight = {
				search = "Search",
				replace = "DiffDelete",
			},
		})

		-- **Global Keybindings**
		vim.keymap.set("n", "ys", function()
			spectre.open()
		end, { desc = "Search in project" })
		vim.keymap.set("n", "yw", function()
			spectre.open_visual({ select_word = true })
		end, { desc = "Search current word in project" })
		vim.keymap.set("v", "yw", function()
			spectre.open_visual()
		end, { desc = "Search selection in project" })
		vim.keymap.set("n", "yf", function()
			spectre.open_file_search({ select_word = true })
		end, { desc = "Search in current file" })
		vim.keymap.set("n", "yq", function()
			require("spectre.actions").send_to_qf()
		end, { desc = "Send results to Quickfix" })
		vim.keymap.set("n", "yr", function()
			require("spectre.actions").replace_cmd()
		end, { desc = "Replace all" })
		vim.keymap.set("n", "yo", function()
			spectre.show_options()
		end, { desc = "Show Spectre options menu" })
	end,
}
