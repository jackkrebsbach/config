return {
  { 'echasnovski/mini.files',
    version = '*',
    enabled = true,
    config = function()
      require('mini.files').setup()
      vim.keymap.set('n', '<leader>ps', MiniFiles.open)
    end
  }
}
