return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp",
    config = function()
      require("luasnip").config.set_config({
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      })

      -- Reload Luanip snippets
      vim.keymap.set('n', '<Leader>L',
        '<Cmd>lua require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})<CR>')

      vim.api.nvim_set_keymap("i", "jk", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
        { expr = true, silent = true })

      vim.api.nvim_set_keymap("s", "jk", "luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'",
        { expr = true, silent = true })

      vim.api.nvim_set_keymap("i", "<S-Tab>", "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'",
        { expr = true, silent = true })

      vim.api.nvim_set_keymap("s", "<S-Tab>", "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'",
        { expr = true, silent = true })
    end
  }

}
