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

      -- PDF to Neovim Search CMD+Shift click
      local function write_server_name()
        local nvim_server_file = vim.fn.has('win32') == 1 and vim.fn.getenv('TEMP') or '/tmp'
        nvim_server_file = nvim_server_file .. '/vimtexserver.txt'
        vim.fn.writefile({ vim.v.servername }, nvim_server_file)
      end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('vimtex_common', { clear = true }),
        pattern = 'tex',
        callback = write_server_name,
      })
    end,
  }
}
