return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	-- lazy = true,
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "Personal",
				path = "~/Documents/Obsidian/Personal",
			},
			{
				name = "Work",
				path = "~/Documents/Obsidian/Work",
			},
		},
		notes_subdir = "00-Inbox",
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "00-Inbox",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, default tags to add to each new daily note created.
			default_tags = { "daily-notes" },
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil
		},
		new_notes_location = "current_dir",
		note_id_func = function(title)
			-- Create note IDs in the format yyyy-mm-dd-title
			-- e.g., '2025-07-07-my-new-note' for a note titled 'My new note'
			local suffix = ""
			if title ~= nil then
				-- Transform title into valid filename
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, add 4 random uppercase letters
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			-- Format current date as yyyy-mm-dd
			return os.date("%Y-%m-%d") .. "-" .. suffix
		end,
		ui = {
			enable = false,
		},
	},
}
