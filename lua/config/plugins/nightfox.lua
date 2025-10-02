return {
  {
    "EdenEast/nightfox.nvim",
    name = "night-fox",
    enabled = true,
    priority = 1000,
    config = function()
      -- setup must be called before loading
      vim.cmd("colorscheme carbonfox")

      local fox = require("nightfox.palette").load("carbonfox")
      vim.api.nvim_set_hl(0, "@markup.italic", { italic = true })
      ---@diagnostic disable-next-line: need-check-nil, undefined-field
      vim.api.nvim_set_hl(0, "CodeCell", { bg = fox.bg0 })
      vim.api.nvim_set_hl(0, "Whitespace", { ctermfg = 104, fg = "#6767d0" })
    end
  }
}
