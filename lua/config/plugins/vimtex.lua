return {
  {
    "lervag/vimtex",
    lazy = false,
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

      -- Inkscape shortcuts
      local inkscape_create = function()
        local line = vim.fn.getline(".")

        ---@diagnostic disable-next-line: undefined-field
        local root = vim.b.vimtex and vim.b.vimtex.root or ''
        if root ~= '' then
          local command = string.format('.!inkscape-figures create "%s" "%s/figures/"', line, root)
          vim.cmd('silent ' .. command)
          vim.cmd('normal! <CR>')
          vim.cmd('w')
        else
          print("vimtex root is not set!")
        end
      end

      local inkscape_edit = function()
        ---@diagnostic disable-next-line: undefined-field
        local root = vim.b.vimtex and vim.b.vimtex.root or ''
        if root ~= '' then
          local command = string.format('!inkscape-figures edit "%s/figures/" > /dev/null', root)
          vim.cmd('silent ' .. command)
          vim.cmd('redraw!')
        else
          print("vimtex root is not set!")
        end
      end

      vim.keymap.set('i', '<C-f>', inkscape_create, { noremap = true, silent = true })
      vim.keymap.set('n', '<C-f>', inkscape_edit, { noremap = true, silent = true })
    end,
  }
}
