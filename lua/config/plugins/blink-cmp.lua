return {
  {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    enabled = true,
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ["<Tab>"] = { 'select_and_accept', 'fallback' },
        ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },

      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  }
}
