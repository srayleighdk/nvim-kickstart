return {
	'ggandor/leap.nvim',
	config = function()
		vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap)')
		vim.keymap.set('n', 'F', '<Plug>(leap-from-window)')
	end,
}
