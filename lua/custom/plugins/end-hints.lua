return {
  'chrisgrieser/nvim-lsp-endhints',
  event = 'LspAttach',
  keys = {
    {
      '<leader>te',
      function()
        require('lsp-endhints').toggle()
      end,
      desc = '[T]oggle [E]nd hints',
    },
  },
  opts = {}, -- required, even if empty
}
