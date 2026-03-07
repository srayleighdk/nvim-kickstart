return {
	'mason-org/mason-lspconfig.nvim',
	opts = {
		ensure_installed = { 'lua_ls' },
		automatic_enable = {
			exclude = {
				'rust_analyzer',
				'ts_ls',
				'dartls',
			},
		},
	},
	dependencies = {
		{ 'mason-org/mason.nvim', opts = {} },
		'neovim/nvim-lspconfig',
	},
}
