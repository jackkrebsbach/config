return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "typescript", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,
        highlight = {
          enable = true,
          ---@diagnostic disable-next-line: unused-local
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
            local disabled = { "latex", "tex" }
            local function isDisabled(lan)
              for _, v in ipairs(disabled) do
                if v == lan then
                  return true
                end
              end
              return false
            end

            if isDisabled(lang) then
              return true
            end
          end,
          additional_vim_regex_highlighting = { "latex" },
        },
      }
    end,
  }
}
