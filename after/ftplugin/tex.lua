vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("vimtex_compile_on_save", { clear = true }),
  pattern = "*.tex",
  callback = function()
    vim.cmd("VimtexCompile")
  end,
})
