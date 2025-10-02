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
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config.julials = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
        end,
      }

      vim.lsp.config.pyright = {
        capabilities = capabilities,
        filetypes = { "python" },
        settings = {
          python = {
            analysis = {
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = false,
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                reportMissingImports = "none",
                reportMissingModuleSource = "none",
                reportUnknownMemberType = "none",
                reportUnknownParameterType = "none",
                reportUnknownVariableType = "none",
                reportUnusedExpression = "none"
              }
            }
          }
        }
      }

      vim.lsp.config.lua_ls = {
        capabilities = capabilities
      }

      vim.lsp.config.tailwindcss = {
        capabilities = capabilities
      }

      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }

      vim.lsp.enable({ 'julials', 'pyright', 'lua_ls', 'tailwindcss', 'ts_ls' })

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
