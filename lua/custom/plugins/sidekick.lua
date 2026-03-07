return {
	"folke/sidekick.nvim",
	opts = {
		-- add any options here
		nes = { enabled = false },
		cli = {
			watch = true, -- notify Neovim of file changes done by AI CLI tools
			---@class sidekick.win.Opts
			win = {
				--- This is run when a new terminal is created, before starting it.
				--- Here you can change window options `terminal.opts`.
				---@param terminal sidekick.cli.Terminal
				config = function(terminal) end,
				wo = {}, ---@type vim.wo
				bo = {}, ---@type vim.bo
				layout = "right", ---@type "float"|"left"|"bottom"|"top"|"right"
				--- Options used when layout is "float"
				---@type vim.api.keyset.win_config
				float = {
					width = 0.9,
					height = 0.9,
				},
				-- Options used when layout is "left"|"bottom"|"top"|"right"
				---@type vim.api.keyset.win_config
				split = {
					width = 80,
					height = 20,
				},
				keys = {
					hide_n = { "q", "hide", mode = "n" }, -- hide the terminal window in normal mode
					hide_t = { "<c-/>", "hide" },    -- hide the terminal window in terminal mode
					hide_t = { "<c-_>", "hide" },    -- tmux
					win_p = { "<c-w>p", "blur" },    -- leave the cli window
					prompt = { "<c-p>", "prompt" },  -- insert prompt or context

					-- nav_left = { "<c-j>", "nav_left", expr = true, desc = "navigate to the left window" },
					-- nav_down = { "<c-k>", "nav_down", expr = true, desc = "navigate to the below window" },
					-- nav_up = { "<c-l>", "nav_up", expr = true, desc = "navigate to the above window" },
					-- nav_right = { "<c-;>", "nav_right", expr = true, desc = "navigate to the right window" },
				},
			},
			mux = {
				backend = "tmux",
				enabled = true,
				create = "terminal", ---@type "terminal"|"window"|"split"
				split = {
					vertical = true, -- vertical or horizontal split
					size = 0.3, -- size of the split (0-1 for percentage)
				},
			},
			tools = {
				cursor = { cmd = { "cursor-agent" } }
			}
		},
		copilot = {
			-- track copilot's status with `didChangeStatus`
			status = {
				enabled = true,
			},
		},
		debug = false, -- enable debug logging
	},
	keys = {
		{
			"<tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			expr = true,
			desc = "Goto/Apply Next Edit Suggestion",
		},
		{
			"<c-.>",
			function() require("sidekick.cli").toggle() end,
			desc = "Sidekick Toggle",
			mode = { "n", "t", "i", "x" },
		},
		{
			"<leader>aa",
			function() require("sidekick.cli").toggle() end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>as",
			function() require("sidekick.cli").select() end,
			-- Or to select only installed tools:
			-- require("sidekick.cli").select({ filter = { installed = true } })
			desc = "Select CLI",
		},
		{
			"<leader>ad",
			function() require("sidekick.cli").close() end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function() require("sidekick.cli").send({ msg = "{this}" }) end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function() require("sidekick.cli").send({ msg = "{file}" }) end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function() require("sidekick.cli").send({ msg = "{selection}" }) end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function() require("sidekick.cli").prompt() end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		-- Example of a keybinding to open Claude directly
		{
			"<leader>ao",
			function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
			desc = "Sidekick Toggle OpenCode",
		},
	},
}
