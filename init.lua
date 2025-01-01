require("config.lazy")
-- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/LuaSnip/" } })

local set = vim.opt

set.shiftwidth = 4
set.number = true
set.relativenumber = true
set.clipboard = "unnamedplus"

-- Comments
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Fix for tree-sitter highlight error
vim.hl = vim.highlight

-- Clear Highlight
vim.api.nvim_set_keymap("n", "<CR>", ":noh<CR><CR>", { noremap = true, silent = true })

-- Prevent jumping
vim.opt.signcolumn = "yes:1"

-- Source lines of code/file
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

--Quick fix cycle
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- LSP references
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
