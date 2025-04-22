-- plugins/text-replace.lua
return {
	-- Spectre: Project-wide find and replace
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Spectre",
		keys = {
			{
				"<leader>sr",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
		},
		opts = {
			mapping = {
				["toggle_line"] = {
					map = "dd",
					cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
					desc = "toggle current item",
				},
				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "goto current file",
				},
				["replace_cmd"] = {
					map = "<leader>rc",
					cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
					desc = "input replace command",
				},
			},
		},
	},

	-- Substitute.nvim: Enhanced substitution commands
	{
		"gbprod/substitute.nvim",
		keys = {
			{
				"s",
				function()
					require("substitute").operator()
				end,
				desc = "Substitute operator",
			},
			{
				"ss",
				function()
					require("substitute").line()
				end,
				desc = "Substitute line",
			},
			{
				"S",
				function()
					require("substitute").eol()
				end,
				desc = "Substitute to end of line",
			},
			{
				"<leader>s",
				function()
					require("substitute.range").operator()
				end,
				desc = "Substitute in range",
			},
			{
				"<leader>ss",
				function()
					require("substitute.range").word()
				end,
				desc = "Substitute word in range",
			},
		},
		opts = {
			on_substitute = nil,
			yank_substituted_text = false,
			preserve_marks = false,
			highlight_substituted_text = {
				enabled = true,
				timer = 500,
			},
		},
	},

	-- vim-abolish: Smart text replacement and coercion
	{
		"tpope/vim-abolish",
		cmd = { "Abolish", "Subvert" },
		keys = {
			{ "cr", desc = "Coercion mappings (crs: snake_case, crm: MixedCase, etc)" },
		},
	},

	-- mini.operators: Text operations including replace
	{
		"echasnovski/mini.operators",
		keys = {
			{ "gr", desc = "Replace text with register" },
			{ "gR", desc = "Exchange text regions" },
		},
		opts = {
			replace = {
				prefix = "gr",
				options = {
					reindent = true,
				},
			},
			exchange = {
				prefix = "gR",
			},
		},
	},

	-- conform.nvim: Code formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { { "prettierd", "prettier" } },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},
}
