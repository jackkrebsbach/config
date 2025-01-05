return {
  {
    "lervag/vimtex",
    lazy = false,
    enabled = true,
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "tectonic"

      vim.keymap.set('n', '<leader>cc', function() print('Tex Compiler: ' .. vim.g.vimtex_compiler_method) end)
      vim.g.vimtex_quickfix_ignore_filters = {
        'LaTeX hooks Warning',
        'Underfull \\hbox',
        'Overfull \\hbox',
        'LaTeX Warning: .- float specifier changed to',
        'Package hyperref Warning: Token not allowed in a PDF string',
        'Fatal error occurred, no output PDF file produced!',
      }
    end,
  }
}
