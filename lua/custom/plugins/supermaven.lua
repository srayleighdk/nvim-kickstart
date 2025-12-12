-- return
-- {
-- 	"supermaven-inc/supermaven-nvim",
-- 	config = function()
-- 		require("supermaven-nvim").setup({
-- 			disable_keymaps = true
-- 		})
-- 	end,
-- }
-- add this to the file where you setup your other plugins:
-- return {
-- 	"monkoose/neocodeium",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		local neocodeium = require("neocodeium")
-- 		neocodeium.setup()
-- 		vim.keymap.set("i", "<A-f>", neocodeium.accept)
-- 	end,
-- }
--
-- return { "zbirenbaum/copilot.lua",
-- 	config = function ()
-- 		requires = {
--     "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
--   },
--
-- 	end
--   }
--
return {
	"zbirenbaum/copilot.lua",
	dependencies = {
		{
			"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
			init = function()
				vim.g.copilot_nes_debounce = 500
				vim.lsp.enable("copilot_ls")
				vim.keymap.set("n", "<tab>", function()
					local bufnr = vim.api.nvim_get_current_buf()
					local state = vim.b[bufnr].nes_state
					if state then
						-- Try to jump to the start of the suggestion edit.
						-- If already at the start, then apply the pending suggestion and jump to the end of the edit.
						local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
								or (
									require("copilot-lsp.nes").apply_pending_nes()
									and require("copilot-lsp.nes").walk_cursor_end_edit()
								)
						return nil
					else
						-- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
						return "<C-i>"
					end
				end, { desc = "Accept Copilot NES suggestion", expr = true })
			end,

		},
	},
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				keymap = {
					accept_word = "<S-l>"
				}
			},
			panel = { enabled = false },
		})
	end,
}
