return {
  {
    -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
    -- for complete functionality (language features)
    'quarto-dev/quarto-nvim',
    enabled = false,
    dev = false,
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = 'curly',
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime',
      },
    },
    dependencies = {
      'jmbuhr/otter.nvim',
    },
  },
}
