return {
  { 'echasnovski/mini.files',
    version = '*',
    enabled = true,
    config = function()
      require('mini.files').setup()
      vim.keymap.set('n', '<leader>f', MiniFiles.open)
    end
  }
}
