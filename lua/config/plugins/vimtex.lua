return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "tectonic"
      vim.keymap.set('n', '<leader>cc', function() print('Tex Compiler: ' .. vim.g.vimtex_compiler_method) end)
    end,
  }
}
