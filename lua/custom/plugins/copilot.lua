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
			nes = {
				enabled = true,
			},
			suggestion = {
				enabled = false,
			},
			panel = { enabled = false },
			filetypes = {
				["grug-far"] = false,
				["grug-far-history"] = false,
				["grug-far-help"] = false,
			}
		})
	end,
}


-- return {
-- 	"zbirenbaum/copilot.lua",
-- 	cmd = "Copilot",
-- 	event = "BufReadPost",
-- 	config = function()
-- 		require("copilot").setup({
-- 			suggestion = {
-- 				enabled = not vim.g.ai_cmp,
-- 				auto_trigger = true,
-- 				hide_during_completion = vim.g.ai_cmp,
-- 				keymap = {
-- 					accept = false, -- handled by nvim-cmp / blink.cmp
-- 					next = "<M-]>",
-- 					prev = "<M-[>",
-- 				},
-- 			},
-- 			panel = { enabled = false },
-- 			filetypes = {
-- 				["grug-far"] = false,
-- 				["grug-far-history"] = false,
-- 				["grug-far-help"] = false,
-- 			}
-- 		})
-- 	end,
-- }
