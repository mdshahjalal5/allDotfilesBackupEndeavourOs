-- ~/.config/nvim/lua/plugins/mongo.lua
return {
	{
		"jrop/mongo.nvim",
		lazy = false, -- Load immediately
		config = function()
			-- Set default MongoDB database
			vim.api.nvim_set_var("mongo_default_db", "my_database")

			-- Keybindings for MongoDB commands
			vim.api.nvim_set_keymap(
				"n",
				"<leader>mc",
				":Mongoconnect --db=my_database<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>mf",
				":Mongoquery db.users.find({})<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>mi",
				":Mongoquery db.users.insertOne({ name: 'NewUser', age: 25 })<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>mu",
				":Mongoquery db.users.updateOne({ name: 'NewUser' }, { $set: { age: 30 } })<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>md",
				":Mongoquery db.users.deleteOne({ name: 'NewUser' })<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>me",
				":Mongoedit --collection=users --id=<ID><CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap("n", "<leader>mr", ":Mongorefresh<CR>", { noremap = true, silent = true })
		end,
	},
}
