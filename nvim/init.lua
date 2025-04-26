-- Set runtimepath similar to what the Vimscript was doing
vim.opt.runtimepath:prepend(vim.fn.expand("~/.vim"))
vim.opt.runtimepath:append(vim.fn.expand("~/.vim/after"))
vim.opt.packpath = vim.opt.runtimepath:get()

-- Source the old .vimrc (if needed)
vim.cmd("source ~/.vimrc")

local languages = {
  'c',
  'diff',
  'json',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'ruby',
  'rust',
  'sql',
  'toml',
  'tsx',
  'vim',
  'yaml',
}

require('nvim-treesitter.configs').setup({
  ensure_installed = languages,
  auto_install = true,
  sync_install = true,
  hihlight = { enable = true },
  indent = { enable = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<S-space>',
    }
  },
  endwise = { enable = false },
})

-- Setup Mason
require("mason").setup()
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end
  },
  view = {
    entries = {name = 'custom', selection_order = 'near_cursor' }
  },
  window = {
    documentation = {
      max_height = 15,
      max_width = 60,
    }
  },
  mapping = cmp.mapping.preset.insert({
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  formatting = {
    fields = { 'abbr', 'menu', 'kind' },
    format = function(entry, item)
      local short_name = {
        nvim_lsp = "[LSP]",
        treesitter = "[Tree]",
        rg = "[RG]",
        buffer = "[Buffer]",
        path = "[Path]",
      }

      local menu_name = short_name[entry.source.name] or entry.source.name

      item.menu = string.format('%s', menu_name)
      return item
    end,
  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      {
        name = 'treesitter',
        option = {
          complete_defer = 100,
          max_items = 10,
          exact_match = false,
          current_buffer_only = false,
        },
      },
      {
        name = 'rg',
        option = {
          complete_defer = 100,
          max_items = 10,
          exact_match = false,
          current_buffer_only = false,
        },
      },
      {
        name = 'buffer',
        option = {
          complete_defer = 100,
          max_items = 10,
          exact_match = false,
          current_buffer_only = true,
        },
      },
      { name = 'path' },
  }),
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "ruby_lsp", "lua_ls", "rust_analyzer", "yamlls",  },
  handlers = {
    function(server_name)
      -- require('lspconfig')[server_name].setup({})
      require('lspconfig')[server_name].setup({capabilities = capabilities,})
    end,
  },
})
