return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_compiler_method = 'tectonic'
      -- Command to compile on write
      vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	callback = function()
	  vim.cmd("VimtexCompile")
	end,
      })
    end,
  }
}
