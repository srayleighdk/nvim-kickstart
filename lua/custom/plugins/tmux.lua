return {
	'aserowy/tmux.nvim',
	config = function()
		require('tmux').setup {
			copy_sync = {
				enable = true,
			}
		}
	end,
}
