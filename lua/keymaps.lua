-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Cycle through buffers' })
vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Cycle through buffers' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

--keymap for better exit nvim
vim.keymap.set('n', '<C-q>', ':q<CR>', { desc = 'Quit Neovim' })
--keymap for exit all nvim
vim.keymap.set('n', '<S-q>', ':qa<CR>', { desc = 'Quit all Neovim' })

vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- keymap for better exit
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Exit insert mode' })

-- close buffer
vim.keymap.set('n', '<leader>bd', ':lua MiniBufremove.delete()<CR>', { desc = 'Close buffer' })

-- setting <C-s> to save file
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })

-- split
vim.keymap.set('n', '_', ':split<CR>', { desc = 'Split horizontal' })
vim.keymap.set('n', '-', ':vsplit<CR>', { desc = 'Split vertical' })

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'Cargo.toml',
  callback = function()
    local crates = require 'crates'

    vim.keymap.del('n', '<leader>cf')

    vim.keymap.set('n', '<leader>ct', crates.toggle, { silent = true, desc = 'Toggle Crates.nvim' })
    -- vim.keymap.set("n", "<leader>cr", crates.reload, opts)

    vim.keymap.set('n', '<leader>cv', crates.show_versions_popup,
      { silent = true, desc = 'Show Crates.nvim versions popup' })
    vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = '[C]rates [F]eatures popup' })
    vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup,
      { silent = true, desc = '[C]rates [D]ependencies popup' })

    vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'Update Crate' })
    vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'Update Crates' })
    -- vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
    vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade Crate' })
    vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade Crates' })
    vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade All Crates' })

    vim.keymap.set('n', '<leader>cx', crates.expand_plain_crate_to_inline_table,
      { silent = true, desc = 'Expand plain Crate to inline table' })
    vim.keymap.set('n', '<leader>cX', crates.extract_crate_into_table,
      { silent = true, desc = 'Extract Crate into table' })

    vim.keymap.set('n', '<leader>cH', crates.open_homepage, { silent = true, desc = 'Open Crates.nvim homepage' })
    vim.keymap.set('n', '<leader>cR', crates.open_repository, { silent = true, desc = 'Open Crates.nvim repository' })
    vim.keymap.set('n', '<leader>cD', crates.open_documentation,
      { silent = true, desc = 'Open Crates.nvim documentation' })
    vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { silent = true, desc = 'Open Crates.io homepage' })
    vim.keymap.set('n', '<leader>cL', crates.open_lib_rs, { silent = true, desc = 'Open Lib.rs homepage' })
  end,
})

-- Obsidian
vim.keymap.set("n", "<leader>on", ":ObsidianNew<CR>", { desc = "New note" })
vim.keymap.set("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Search notes" })
vim.keymap.set("n", "<leader>of", ":ObsidianFollowLink<CR>", { desc = "Follow link" })
vim.keymap.set("n", "<leader>ot", ":ObsidianTOC<CR>", { desc = "Table of contents" })
vim.keymap.set("n", "<leader>op", ":ObsidianPasteImg<CR>", { desc = "Paste image" })

-- vim: ts=2 sts=2 sw=2 et
