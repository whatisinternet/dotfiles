-- Initialize the plugin list
local plugins = {

  -- Core dependencies
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }
  },

  -- FZF
  {
    "junegunn/fzf",
    build = "./install --all",
    dir = "~/.fzf",
    cmd = "Files"
  },
  {
    "junegunn/fzf.vim",
    cmd = "Files"
  },

  -- Git
  { "tpope/vim-fugitive", cmd = "Git" },
  { "airblade/vim-gitgutter", event = "BufReadPre" },

  -- Navigation
  { "scrooloose/nerdtree", lazy = false },
  { "Xuyuanp/nerdtree-git-plugin", lazy = true },
  { "PhilRunninger/nerdtree-visual-selection", lazy = true },

  -- Lightline
  { "itchyny/lightline.vim", event = "VeryLazy" },

  -- Autocomplete and LSP
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "ray-x/cmp-treesitter",
        "lukas-reineke/cmp-rg",
        "hrsh7th/cmp-nvim-lsp-signature-help",
    }
  },
  { "williamboman/mason.nvim", cmd = "Mason" },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "neovim/nvim-lspconfig", event = { "BufReadPre" } },

  -- Colorschemes
  { "shaunsingh/solarized.nvim", lazy = true },
  { "craftzdog/solarized-osaka.nvim", lazy = true },

  -- Languages
  { "pangloss/vim-javascript", ft = "javascript" },
  { "thoughtbot/vim-rspec", ft = "ruby" },
  { "tpope/vim-rails", ft = "ruby" },
  { "vim-ruby/vim-ruby", ft = "ruby" },
  { "fatih/vim-go", ft = "go" },
  { "mxw/vim-jsx", ft = "javascriptreact" },
  { "leafgarland/typescript-vim", ft = "typescript" },
  { "peitalin/vim-jsx-typescript", ft = "typescriptreact" },
  { "jparise/vim-graphql", ft = "graphql" },

  -- AI-specific (env-based conditional loading)
  (os.getenv("USE_LOCAL_AI") == "1" and {
    { "stevearc/dressing.nvim", lazy = true },
    { "MeanderingProgrammer/render-markdown.nvim", lazy = true },
    {
      "yetone/avante.nvim",
      branch = "main",
      build = "make",
      lazy = true
    },
  } or nil),

  -- Utilities & Dev
  { "christoomey/vim-run-interactive", cmd = "RunInteractive" },
  { "pbrisbin/vim-mkdir", event = "BufWritePre" },
  { "w0rp/ale", event = "BufRead" },
  { "tpope/vim-unimpaired", event = "VeryLazy" },
  { "tpope/vim-jdaddy", ft = "json" },
  { "tpope/vim-abolish", cmd = { "S", "Abolish" } },
  { "tpope/vim-speeddating", event = "VeryLazy" },
  { "tpope/vim-bundler", ft = "ruby" },
  { "tpope/vim-endwise", ft = { "ruby", "lua" } },
  { "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },
  { "tpope/vim-repeat", lazy = true },
  { "tpope/vim-surround", keys = { "cs", "ds", "ys" } },
  { "vim-scripts/tComment", keys = { "gc", "gcc" } },

}

-- Add optional local plugins (if local.lua exists)
local ok, local_plugins = pcall(require, "plugins.local")
if ok then
  for _, plugin in ipairs(local_plugins) do
    table.insert(plugins, plugin)
  end
end

return plugins
