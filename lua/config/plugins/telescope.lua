return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {},
          -- inkscape_figures = {}
        }
      }

      local builtin = require('telescope.builtin')

      vim.keymap.set("n", "<space>fh", builtin.help_tags)
      vim.keymap.set("n", "<space>ff", builtin.find_files)

      vim.keymap.set("n", "<space>en", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end
      )
    end,
  },
}
