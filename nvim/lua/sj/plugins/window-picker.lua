return {
	"s1n7ax/nvim-window-picker",
	opts = {
		autoselect_one = true, -- Auto-select if only one window is available
		include_current = false, -- Exclude the current window from selection
		filter_rules = {
			bo = {
				filetype = { "NvimTree", "neo-tree", "notify" }, -- Exclude specific filetypes
				buftype = { "terminal", "quickfix" }, -- Exclude specific buffer types
			},
		},
		highlights = {
			statusline = {
				focused = { fg = "#FFFFFF", bg = "#FF0000", bold = true },
				unfocused = { fg = "#CCCCCC", bg = "#333333", bold = false },
			},
		},
	},
	config = function(_, opts)
		require("window-picker").setup(opts)
		vim.keymap.set("n", "<leader>ww", function()
			local picked_window = require("window-picker").pick_window() -- Pick a window
			if picked_window then
				vim.api.nvim_set_current_win(picked_window)
			end
		end, { desc = "Pick a window" })
	end,
}
