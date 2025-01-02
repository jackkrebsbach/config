return {
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',
    enabled = true,
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ["<C-j>"] = { 'select_and_accept', 'fallback' },
        ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'luasnip' },
      },
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  }
}
