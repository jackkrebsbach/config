require("config.lazy")
local set = vim.opt

set.shiftwidth = 4
set.number = true
set.relativenumber = true
set.clipboard = "unnamedplus"

-- Lua Snip
-- Lazy-load snippets, i.e. only load when required, e.g. for a given filetype
require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/LuaSnip/" } })

-- Fix for tree-sitter highlight error
vim.hl = vim.highlight

-- Mini files
---@diagnostic disable-next-line: undefined-global
vim.keymap.set('n', '<leader>f', MiniFiles.open)

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


vim.opt.signcolumn = "yes:1"

vim.keymap.set('i', '<C-f>', inkscape_create, { noremap = true, silent = true })
vim.keymap.set('n', '<C-f>', inkscape_edit, { noremap = true, silent = true })

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
