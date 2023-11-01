return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"zbirenbaum/copilot-cmp",
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"onsails/lspkind.nvim",
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		lspkind.init({
			symbol_map = {
				Copilot = "",
			},
		})

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.opt.completeopt = "menu,menuone,noselect"
		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg ="#6CC644" })

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), --
				["<C-j>"] = cmp.mapping.select_next_item(), --
				["<C-b>"] = cmp.mapping.scroll_docs(-4), --
				["<C-f>"] = cmp.mapping.scroll_docs(4), --
				["<C-Space>"] = cmp.mapping.complete(), --
				["<C-e>"] = cmp.mapping.abort(), --
				['<CR>'] = cmp.mapping.confirm({
					-- behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				})
			}),
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" }, -- lsp
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}

