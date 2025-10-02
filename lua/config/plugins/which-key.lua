-- show keybinding help window
return {
  {
    'folke/which-key.nvim',
    enabled = false,
    config = function()
      require('which-key').setup {}
      -- require 'config.keymap'
    end,
  },
}
