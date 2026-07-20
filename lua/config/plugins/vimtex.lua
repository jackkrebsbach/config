return {
  {
    "lervag/vimtex",
    lazy = false,
    enabled = true,
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = "tectonic"

      function ToggleCompiler()
        if vim.g.vimtex_compiler_method == "tectonic" then
          vim.g.vimtex_compiler_method = "latexmk"
        else
          vim.g.vimtex_compiler_method = "tectonic"
        end
        print("Compiler set to: " .. vim.g.vimtex_compiler_method)
      end

      vim.api.nvim_set_keymap("n", "<leader>sc", ":lua ToggleCompiler()<CR>", { noremap = true, silent = true })

      vim.keymap.set('n', '<leader>cc', function() print('Tex Compiler: ' .. vim.g.vimtex_compiler_method) end)

      -- tectonic emits traditional-format TeX errors ("! Missing $ inserted."
      -- + "l.34"), but VimTeX's quickfix parser expects -file-line-error
      -- style ("file:34: ...") and silently drops them, leaving only
      -- warnings. The raw compiler output DOES contain the real error
      -- ("error: file:line: message"), so expose it directly.
      vim.keymap.set('n', '<leader>co', '<cmd>VimtexCompileOutput<CR>',
        { noremap = true, silent = true, desc = 'VimTeX: raw compiler output (real errors)' })
      -- Parse the compile log with `pplatex` instead of VimTeX's built-in
      -- errorformat. VimTeX's default expects -file-line-error output, which
      -- tectonic does not produce, so real errors get dropped from the
      -- quickfix. pplatex understands tectonic's traditional log format.
      -- (Requires `pplatex` on PATH; installed to ~/.local/bin.)
      vim.g.vimtex_quickfix_method = 'pplatex'
      -- Only pop the quickfix list open when there are real errors, not
      -- for warning-only builds.
      vim.g.vimtex_quickfix_open_on_warning = 0
      -- Filter out warning noise only. Do NOT filter compile-failure lines
      -- (e.g. "Fatal error occurred, no output PDF file produced!"), or a
      -- failed build looks just like a successful one in the quickfix list.
      vim.g.vimtex_quickfix_ignore_filters = {
        'LaTeX hooks Warning',
        'Underfull \\hbox',
        'Overfull \\hbox',
        'LaTeX Warning: .- float specifier changed to',
        'Package hyperref Warning: Token not allowed in a PDF string',
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
