local blinkcapabilities = require('blink.cmp').get_lsp_capabilities()
local lspcapabilities = vim.lsp.protocol.make_client_capabilities()
return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  keys = {
    { '<leader>fr', ':FlutterRun<CR>', desc = 'Flutter Run' },
    { '<leader>fl', ':FlutterLogToggle<CR>', desc = 'Flutter Log' },
    { '<leader>fc', ':FlutterLogClear<CR>', desc = 'Flutter Console' },
    { '<leader>fq', ':FlutterQuit<CR>', desc = 'Flutter Packages' },
    { '<leader>fd', ':FlutterRestart<CR>', desc = 'Flutter Version' },
    { '<leader>fs', ':FlutterReload<CR>', desc = 'Flutter Docs' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  opts = {
    widget_guides = {
      enabled = true,
    },
    lsp = {
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
        -- buf_set_keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'LSP: Format buffer')

        -- Diagnostics keybindings
        buf_set_keymap('n', '<leader>e', vim.diagnostic.open_float, 'LSP: Show line diagnostics')
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
      capabilities = vim.tbl_deep_extend('force', {}, blinkcapabilities, lspcapabilities),
    },
  },
}
