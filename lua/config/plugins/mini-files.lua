return {
  {
    'echasnovski/mini.files',
    version = '*',
    enabled = true,
    config = function()
      require('mini.files').setup({
        content = {
          filter = function(entry)
            return entry.name ~= '.DS_Store'
          end,
        },
      })
      vim.keymap.set('n', '<leader>ps', MiniFiles.open)
    end
  }
}
