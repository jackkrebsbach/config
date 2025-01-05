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
          inkscape_figures = {}
        }
      }

      local telescope = require("telescope")
      local builtin = require('telescope.builtin')

      vim.keymap.set(
        "i",
        "<C-f>",
        "<Esc><cmd>exec 'r!inkscape-figures-manager new -f -d figures -l \"'.getline('.').'\"'<CR>"
      )

      vim.keymap.set("n", "<leader>fi", telescope.extensions.inkscape_figures.inkscape_figures, {})
      vim.keymap.set("n", "<space>fh", builtin.help_tags)
      vim.keymap.set("n", "<space>ff", builtin.find_files)

      vim.keymap.set("n", "<space>en", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end
      )
    end,
  }
}
