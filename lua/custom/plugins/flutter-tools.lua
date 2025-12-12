local blinkcapabilities = require('blink.cmp').get_lsp_capabilities()
local lspcapabilities = vim.lsp.protocol.make_client_capabilities()

local capabilities = vim.tbl_deep_extend('force', {}, blinkcapabilities, lspcapabilities)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
return {
	'nvim-flutter/flutter-tools.nvim',
	lazy = false,
	keys = {
		{ '<leader>fr', ':FlutterRun<CR>',       { noremap = true, silent = true } },
		{ '<leader>fl', ':FlutterLogToggle<CR>', { noremap = true, silent = true } },
		{ '<leader>fc', ':FlutterLogClear<CR>',  { noremap = true, silent = true } },
		{ '<leader>fq', ':FlutterQuit<CR>',      { noremap = true, silent = true } },
		{ '<leader>fd', ':FlutterRestart<CR>',   { noremap = true, silent = true } },
		{ '<leader>fs', ':FlutterReload<CR>',    { noremap = true, silent = true } },
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'stevearc/dressing.nvim', -- optional for vim.ui.select
	},
	opts = {
		ui = {
			-- the border type to use for all floating windows, the same options/formats
			-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
			border = 'rounded',
			-- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
			-- please note that this option is eventually going to be deprecated and users will need to
			-- depend on plugins like `nvim-notify` instead.
			notification_style = 'plugin',
		},
		widget_guides = {
			enabled = true,
		},
		dev_log = {
			enabled = true,
			filter = nil, -- optional callback to filter the log
			-- takes a log_line as string argument; returns a boolean or nil;
			-- the log_line is only added to the output if the function returns true
			notify_errors = false, -- if there is an error whilst running then notify the user
			open_cmd = "15split", -- command to use to open the log buffer
			focus_on_open = false, -- focus on the newly opened log window
		},
		lsp = {
			color = { -- show the derived colours for dart variables
				enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
				background = false, -- highlight the background
				background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
				foreground = false, -- highlight the foreground
				virtual_text = true, -- show the highlight using virtual text
				virtual_text_str = '■', -- the virtual text character to highlight
			},
			on_attach = function(client, bufnr)
				-- Helper function to simplify keymap creation
				local function buf_set_keymap(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
				end

				-- Common LSP keybindings
				buf_set_keymap('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to definition')
				buf_set_keymap('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to declaration')
				buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, 'LSP: Go to implementation')
				buf_set_keymap('n', 'gr', vim.lsp.buf.references, 'LSP: Find references')
				buf_set_keymap('n', 'K', vim.lsp.buf.hover, 'LSP: Show hover documentation')
				buf_set_keymap('n', '<leader>rn', vim.lsp.buf.rename, 'LSP: Rename symbol')
				buf_set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, 'LSP: Code action')
				buf_set_keymap('n', lhs, rhs, desc)
				-- buf_set_keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'LSP: Format buffer')

				-- Diagnostics keybindings
				-- buf_set_keymap('n', '<leader>e', vim.diagnostic.open_float, 'LSP: Show line diagnostics')
				-- buf_set_keymap('n', '[d', vim.diagnostic.goto_prev, 'LSP: Go to previous diagnostic')
				-- buf_set_keymap('n', ']d', vim.diagnostic.goto_next, 'LSP: Go to next diagnostic')
				-- buf_set_keymap('n', '<leader>q', vim.diagnostic.setloclist, 'LSP: Add diagnostics to location list')

				-- Inlay hints support if available
				-- if client.server_capabilities.inlayHintProvider then
				--   vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				--   buf_set_keymap('n', '<leader>ti', function()
				--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				--   end, 'LSP: Toggle inlay hints')
				-- end

				-- setting keymap to toggle inlay hint
				buf_set_keymap('n', '<leader>ti', function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
				end, 'LSP: Toggle inlay hint')
				-- Highlight symbol under cursor if supported
				if client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
					vim.api.nvim_clear_autocmds { buffer = bufnr, group = 'lsp_document_highlight' }
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						group = 'lsp_document_highlight',
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd('CursorMoved', {
						group = 'lsp_document_highlight',
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
			capabilities = capabilities,
			settings = {
				completeFunctionCalls = true,
				showTodos = true,
				enableSnippets = true,
				updateImportsOnRename = true,
				renameFilesWithClasses = 'prompt', -- "always"
			},
		},
	},
}
