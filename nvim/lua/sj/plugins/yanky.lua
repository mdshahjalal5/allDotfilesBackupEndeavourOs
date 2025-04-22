-- return {
-- 	"gbprod/yanky.nvim",
-- 	opts = {
-- 		ring = {
-- 			history_length = 100,
-- 			storage = "shada",
-- 			sync_with_numbered_registers = true,
-- 			cancel_event = "update",
-- 			ignore_registers = { "_" },
-- 			update_register_on_cycle = false,
-- 		},
-- 		system_clipboard = {
-- 			sync_with_ring = true,
-- 		},
-- 	},
-- 	config = function(_, opts)
-- 		-- Load the configuration for yanky.nvim
-- 		require("yanky").setup(opts)
--
-- 		-- Set keymaps after setting up Yanky with the options
-- 		vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Yanky Put After" })
-- 		vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Yanky Put Before" })
-- 		vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Yanky GPut After" })
-- 		vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Yanky GPut Before" })
-- 		vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "Yanky Previous Entry" })
-- 		vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)", { desc = "Yanky Next Entry" })
-- 	end,
-- }
--
--
--
--
return {
	"gbprod/yanky.nvim",
	dependencies = {
		{ "kkharji/sqlite.lua" },
	},
	opts = {
		ring = { storage = "sqlite" },
	},
	keys = {
		{
			"<leader>yp",
			function()
				require("telescope").extensions.yank_history.yank_history({})
			end,
			desc = "Open Yank History",
		},
		{
			"y",
			"<Plug>(YankyYank)",
			mode = { "n", "x" },
			desc = "Yank text",
		},
		{
			"p",
			"<Plug>(YankyPutAfter)",
			mode = { "n", "x" },
			desc = "Put yanked text after cursor",
		},
		{
			"P",
			"<Plug>(YankyPutBefore)",
			mode = { "n", "x" },
			desc = "Put yanked text before cursor",
		},
		{
			"gp",
			"<Plug>(YankyGPutAfter)",
			mode = { "n", "x" },
			desc = "Put yanked text after selection",
		},
		{
			"gP",
			"<Plug>(YankyGPutBefore)",
			mode = { "n", "x" },
			desc = "Put yanked text before selection",
		},
		{ "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
		{ "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
		{ "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
		{ "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
		{ "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
		{ "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
		{ ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
		{ "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
		{ ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
		{ "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
		{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
		{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
	},
	-- Insert mode key mapping for opening Yank History using Telescope
	vim.api.nvim_set_keymap(
		"i",
		"<leader>yp",
		[[<Esc>:lua require("telescope").extensions.yank_history.yank_history({})<CR>]],
		{ noremap = true, silent = true }
	),
}
