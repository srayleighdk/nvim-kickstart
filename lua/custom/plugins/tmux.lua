return {
	'aserowy/tmux.nvim',
	config = function()
		require('tmux').setup {
			copy_sync = {
				enable = true,
				-- This is usually the problematic part
				redirect_to_clipboard = false, -- try false first
				sync_clipboard = false,    -- ← often helps avoid the blob sync
				sync_registers = false,    -- or {} to disable register sync
			},
		}
	end,
}
