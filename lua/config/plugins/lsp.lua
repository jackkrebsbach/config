return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = { "lua", "typescript", "tex", "r" },
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("lspconfig").lua_ls.setup {
        capabilities = capabilities
      }
      require("lspconfig").tailwindcss.setup {
        capabilities = capabilities
      }
      require 'lspconfig'.r_language_server.setup {
        capabilities = capabilities
      }
      require("lspconfig").ts_ls.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false -- So prettier is used in formatting
        end,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then return end

          if c.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
              end,
            })
          end
        end,
      })
    end,
  }
}
