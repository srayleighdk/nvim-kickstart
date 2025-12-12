-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	lazy = true,
-- 	event = "BufRead */md/*",
-- 	dependencies = {
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 		"hrsh7th/cmp-calc",
-- 		"hrsh7th/cmp-cmdline",
-- 		"saadparwaiz1/cmp_luasnip",
-- 		"onsails/lspkind-nvim",
-- 		{
-- 			'L3MON4D3/LuaSnip',
-- 			version = '2.*',
-- 			build = (function()
-- 				-- Build Step is needed for regex support in snippets.
-- 				-- This step is not supported in many windows environments.
-- 				-- Remove the below condition to re-enable on windows.
-- 				if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
-- 					return
-- 				end
-- 				return 'make install_jsregexp'
-- 			end)(),
-- 			dependencies = {
-- 				-- `friendly-snippets` contains a variety of premade snippets.
-- 				--    See the README about individual language/framework/plugin snippets:
-- 				--    https://github.com/rafamadriz/friendly-snippets
-- 				{
-- 					'rafamadriz/friendly-snippets',
-- 					config = function()
-- 						require('luasnip.loaders.from_vscode').lazy_load()
-- 					end,
-- 				},
-- 			},
-- 			opts = {},
-- 		},
-- 	},
-- 	config = function()
-- 		local cmp = require 'cmp'
-- 		local lspkind = require 'lspkind'
-- 		local luasnip = require 'luasnip'
-- 		-- local neocodeium = require("neocodeium")
-- 		-- local commands = require("neocodeium.commands")
--
-- 		local kind_icons = {
-- 			Text = "",
-- 			Method = "󰆧",
-- 			Function = "󰊕",
-- 			Constructor = "",
-- 			Field = "󰇽",
-- 			Variable = "󰂡",
-- 			Class = "󰠱",
-- 			Interface = "",
-- 			Module = "",
-- 			Property = "󰜢",
-- 			Unit = "",
-- 			Value = "󰎠",
-- 			Enum = "",
-- 			Keyword = "󰌋",
-- 			Snippet = "",
-- 			Color = "󰏘",
-- 			File = "󰈙",
-- 			Reference = "",
-- 			Folder = "󰉋",
-- 			EnumMember = "",
-- 			Constant = "󰏿",
-- 			Struct = "",
-- 			Event = "",
-- 			Operator = "󰆕",
-- 			TypeParameter = "󰅲",
-- 			Supermaven = "",
-- 			Copilot = "",
-- 		}
--
-- 		cmp.setup({
-- 			view = {
-- 				entries = { name = 'custom', selection_order = 'near_cursor' }
-- 			},
-- 			snippet = {
-- 				-- REQUIRED - you must specify a snippet engine
-- 				expand = function(args)
-- 					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
-- 					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
-- 					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
-- 					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
-- 					-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--
-- 					-- For `mini.snippets` users:
-- 					-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
-- 					-- insert({ body = args.body }) -- Insert at cursor
-- 					-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
-- 					-- require("cmp.config").set_onetime({ sources = {} })
-- 				end,
-- 			},
-- 			-- window = {
-- 			-- 	completion = cmp.config.window.bordered(),
-- 			-- 	documentation = cmp.config.window.bordered(),
-- 			-- },
-- 			mapping = cmp.mapping.preset.insert({
-- 				['<C-b>'] = cmp.mapping.scroll_docs(-4),
-- 				['<C-f>'] = cmp.mapping.scroll_docs(4),
-- 				['<C-Space>'] = cmp.mapping.complete(),
-- 				['<C-e>'] = cmp.mapping.abort(),
-- 				['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
-- 				['<S-l>'] = cmp.mapping(function(fallback)
-- 					if luasnip.locally_jumpable(1) then
-- 						luasnip.jump(1)
-- 					elseif cmp.visible() then
-- 						cmp.select_next_item()
-- 					else
-- 						fallback()
-- 					end
-- 				end, { 'i', 's' }),
-- 				['<S-h>'] = cmp.mapping(function(fallback)
-- 					if luasnip.locally_jumpable(-1) then
-- 						luasnip.jump(-1) -- Jump to previous snippet
-- 					elseif cmp.visible() then
-- 						cmp.select_prev_item()
-- 					else
-- 						fallback() -- Jump to previous position in buffer
-- 					end
-- 				end, { 'i', 's' }),
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "copilot",        group_index = 2 },
-- 				{ name = 'nvim_lsp' },
-- 				-- { name = 'vsnip' }, -- For vsnip users.
-- 				{ name = 'luasnip' }, -- For luasnip users.
-- 				{ name = 'lazydev',        group_index = 0 },
-- 				-- { name = 'supermaven' },
-- 				{ name = 'path' },
-- 				{ name = 'render-markdown' },
-- 				{ name = 'calc' }
-- 				-- { name = 'ultisnips' }, -- For ultisnips users.
-- 				-- { name = 'snippy' }, -- For snippy users.
-- 			}, {
-- 				{ name = 'buffer' },
-- 			}),
-- 			formatting = {
-- 				format = function(entry, vim_item)
-- 					-- Kind icons
-- 					vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
-- 					-- Source
-- 					vim_item.menu = ({
-- 						buffer = "[Buffer]",
-- 						nvim_lsp = "[LSP]",
-- 						luasnip = "[LuaSnip]",
-- 						nvim_lua = "[Lua]",
-- 						latex_symbols = "[LaTeX]",
-- 					})[entry.source.name]
-- 					return vim_item
-- 				end
-- 			},
-- 		})
-- 		-- If you want insert `(` after select function or method item
-- 		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- 		cmp.event:on(
-- 			'confirm_done',
-- 			cmp_autopairs.on_confirm_done()
-- 		)
--
-- 		cmp.event:on("menu_opened", function()
-- 			vim.b.copilot_suggestion_hidden = true
-- 		end)
--
-- 		cmp.event:on("menu_closed", function()
-- 			vim.b.copilot_suggestion_hidden = false
-- 		end)
--
--
-- 		local has_words_before = function()
-- 			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
-- 		end
-- 		cmp.setup({
-- 			mapping = {
-- 				["<Tab>"] = vim.schedule_wrap(function(fallback)
-- 					if cmp.visible() and has_words_before() then
-- 						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
-- 					else
-- 						fallback()
-- 					end
-- 				end),
-- 			},
-- 		})
--
--
-- 		-- cmp.event:on("menu_opened", function()
-- 		-- 	neocodeium.clear()
-- 		-- end)
-- 		-- neocodeium.setup({
-- 		-- 	filter = function()
-- 		-- 		return not cmp.visible()
-- 		-- 	end,
-- 		-- })
-- 		-- cmp.setup({
-- 		-- 	completion = {
-- 		-- 		autocomplete = false,
-- 		-- 	},
-- 		-- })
-- 		-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- 		-- Set configuration for specific filetype.
-- 		--[[ cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--       { name = 'git' },
--     }, {
--       { name = 'buffer' },
--     })
--  })
--  require("cmp_git").setup() ]] --
--
-- 		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- 		cmp.setup.cmdline({ '/', '?' }, {
-- 			mapping = cmp.mapping.preset.cmdline(),
-- 			sources = {
-- 				{ name = 'buffer' }
-- 			}
-- 		})
--
-- 		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- 		cmp.setup.cmdline(':', {
-- 			mapping = cmp.mapping.preset.cmdline(),
-- 			sources = cmp.config.sources({
-- 				{ name = 'path' }
-- 			}, {
-- 				{
-- 					name = 'cmdline',
-- 					option = {
-- 						ignore_cmds = { 'Man', '!' }
-- 					}
-- 				}
-- 			})
-- 		})
--
-- 		-- Set up lspconfig.
-- 		-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 		-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- 		-- require('lspconfig')['marksman'].setup {
-- 		-- 	capabilities = capabilities
-- 		-- }
-- 	end,
-- }
--
--
return {
	"saghen/blink.cmp",
	version = '1.*',
	build = 'cargo build --release',
	dependencies = {
		"fang2hou/blink-copilot",
		"onsails/lspkind-nvim",
		"joelazar/blink-calc",
		{
			'L3MON4D3/LuaSnip',
			dependencies = {
				"rafamadriz/friendly-snippets"
			},
			version = '2.*',
			build = 'make install_jsregexp',
			opts = {},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		{
			'Kaiser-Yang/blink-cmp-dictionary',
			dependencies = { 'nvim-lua/plenary.nvim' }
		}
	},
	opts = {
		appearance = {
			nerd_font_variant = 'normal'
		},
		completion = {
			documentation = {
				auto_show = true,
				border = 'single',
			}
		},
		signature = { enabled = true },
		snippets = {
			preset = 'luasnip'
		},

		sources = {
			default = { "lsp", "path", "buffer", "snippets", "copilot", "calc", "dictionary" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
				calc = {
					name = 'Calc',
					module = 'blink-calc',
				},
				dictionary = {
					module = 'blink-cmp-dictionary',
					name = 'Dict',
					-- Make sure this is at least 2.
					-- 3 is recommended
					min_keyword_length = 3,
					opts = {
						-- options for blink-cmp-dictionary
					}
				}
			},
		},
		keymap = {
			preset = "enter",
			['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
			['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },

		},
		cmdline = {
			keymap = { preset = 'inherit' },
			completion = { menu = { auto_show = true } },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
