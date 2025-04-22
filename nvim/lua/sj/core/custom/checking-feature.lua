vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true }) -- Escape terminal mode
vim.api.nvim_set_keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], { noremap = true }) -- Navigate left
vim.api.nvim_set_keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], { noremap = true }) -- Navigate right
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true }) -- Navigate down
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true }) -- Navigate up
vim.api.nvim_set_keymap("n", "<leader>tz", ":split | terminal<CR>", { noremap = true, silent = true })

if vim.g.started_by_firenvim then
	-- General configuration for Firenvim
	vim.g.firenvim_config = {
		globalSettings = {
			alt = "all",
		},
		localSettings = {
			[".*"] = {
				cmdline = "neovim",
				priority = 0,
				selector = "textarea",
				takeover = "never",
			},
		},
	}

	-- Setup function for Firenvim
	local function setup_firenvim()
		vim.opt.filetype = "markdown"
		vim.opt.ruler = false
		vim.opt.showcmd = false
		vim.opt.laststatus = 0
		vim.opt.showtabline = 0
	end

	-- Autocommand group for Firenvim
	vim.api.nvim_create_augroup("Firenvim", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = "Firenvim",
		pattern = "text",
		callback = setup_firenvim,
	})
end

--w: Map space ak to set lines to 100 for firenvim
vim.api.nvim_set_keymap("n", "<Space>bk", ":set lines=80<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Space>bk", ":set lines=100<CR>", { noremap = true, silent = true })

--w: open the current file in browser
vim.api.nvim_set_keymap("n", "<space>ss", [[:!xdg-open %<CR>]], { noremap = true, silent = true })
--w: open the current file in browser
vim.api.nvim_set_keymap("i", "<space>ss", [[<Esc>:!xdg-open %<CR>]], { noremap = true, silent = true })

--
--
--
--
--
--w: open github live site with  browser dynamically find the live site url and open it in the browser
local function open_github_pages()
	-- Get the remote URL of the GitHub repository
	local handle = io.popen("git config --get remote.origin.url")
	if not handle then
		return
	end
	local repo_url = handle:read("*a"):gsub("%s+", "") -- Trim whitespace
	handle:close()

	-- Extract GitHub username and repo name using pattern matching
	local username, repo = repo_url:match("github%.com[:/]([^/]+)/([^%.]+)")

	if username and repo then
		-- Construct the GitHub Pages URL
		local gh_pages_url = string.format("https://%s.github.io/%s/", username, repo)

		-- Print the URL and open it in Google Chrome
		print("Opening: " .. gh_pages_url)
		os.execute("google-chrome-stable " .. gh_pages_url .. " &")
	else
		print("❌ Not a valid GitHub repository!")
	end
end

-- Map it to a Neovim command
vim.api.nvim_create_user_command("OpenGitHubPages", open_github_pages, {})

-- Map it to <leader>gu
vim.keymap.set("n", "<leader>gu", open_github_pages, { noremap = true, silent = true })

-- Function to prompt for old_text/new_text in a single input, then run :%s/old_text/new_text/c
local function interactive_replace()
	-- Prompt for input in the format "old_text/new_text"
	local input = vim.fn.input("Enter old_text/new_text: ")
	if input == "" then
		print("No input entered. Aborting.")
		return
	end

	-- Split the input into old_text and new_text
	local old_text, new_text = input:match("([^/]+)/(.+)")
	if not old_text or not new_text then
		print("Invalid input format. Use 'old_text/new_text'.")
		return
	end

	-- Construct and run the substitute command
	local cmd = string.format("%%s/%s/%s/gc", vim.fn.escape(old_text, "/\\"), vim.fn.escape(new_text, "/\\"))
	vim.cmd(cmd)
end

vim.keymap.set(
	{ "n", "i" },
	"<M-f>",
	interactive_replace,
	{ noremap = true, silent = false, desc = "Interactive search and replace" }
)

--w: open the project with vite
-- Add this to your Neovim config (init.lua)
-- Add to your Neovim config (init.lua)
vim.keymap.set("n", "<leader>ai", function()
	-- Check if we're in a project with Vite
	local has_vite = vim.fn.filereadable("node_modules/.bin/vite") == 1

	if not has_vite then
		vim.notify("Vite not found in current project", vim.log.levels.ERROR)
		return
	end

	-- Check if we're in tmux
	if vim.env.TMUX == nil then
		vim.notify("Not in a tmux session", vim.log.levels.ERROR)
		return
	end

	-- List available panes and prompt for selection
	local tmux_panes = vim.fn.system('tmux list-panes -F "#{pane_index}"')
	vim.ui.select(vim.split(tmux_panes, "\n", { trimempty = true }), {
		prompt = "Select tmux pane to run Vite:",
	}, function(pane)
		if pane then
			-- Send command to selected tmux pane
			vim.fn.system(string.format('tmux send-keys -t %s "npx vite" Enter', pane))
			vim.notify("Vite server started in tmux pane " .. pane, vim.log.levels.INFO)
		end
	end)
end, { noremap = true, silent = true, desc = "Start Vite in tmux pane" })

--w: Jump inside next curly braces (insert mode)
-- vim.keymap.set("i", "<leader>k", "<Esc>/{<CR>a<CR><Esc>O")
-- Jump inside next curly braces (normal mode)
vim.keymap.set("n", "<leader>k", "/{<CR>:nohlsearch<CR>a<CR><Esc>O")

-- Jump inside next curly braces (insert mode)
vim.keymap.set("i", "<leader>kk", "<Esc>/{<CR>:nohlsearch<CR>a<CR><Esc>O")

vim.keymap.set("n", "<M-,>", "Iexport <Esc>", {

	noremap = true,
	silent = true,
})
vim.keymap.set("i", "<M-,>", "<C-o>Iexport <Esc>", {

	noremap = true,
	silent = true,
})
