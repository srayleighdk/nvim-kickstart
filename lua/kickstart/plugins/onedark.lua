-- return {
--   'navarasu/onedark.nvim',
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require('onedark').setup {
--       style = 'darker',
--       transparent = true,
--       -- lualine = {
--       --   transparent = true,
--       -- },
--       code_style = {
--         comments = 'italic',
--         keywords = 'italic,bold',
--         functions = 'bold',
--         strings = 'none',
--         variables = 'none',
--       },
--     }
--     -- Enable theme
--     require('onedark').load()
--   end,
-- }

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  -- opts = {
  --   transparent = true,
  --   styles = {
  --     sidebars = "transparent",
  --     floats = "transparent",
  --   },
  --   cache = false,
  -- },
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true, bold = true },
        functions = { bold = true },
        strings = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      cache = false,
    })
    vim.cmd("colorscheme tokyonight-night")
  end,
}

-- vim: ts=2 sts=2 sw=2 et
