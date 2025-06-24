return {
  'navarasu/onedark.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'darker',
      transparent = true,
      lualine = {
        transparent = true,
      },
      code_style = {
        comments = 'italic',
        keywords = 'italic,bold',
        functions = 'bold',
        strings = 'none',
        variables = 'none',
      },
    }
    -- Enable theme
    require('onedark').load()
  end,
}
-- vim: ts=2 sts=2 sw=2 et
