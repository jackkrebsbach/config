return {
  {
    "EdenEast/nightfox.nvim",
    name = "night-fox",
    enabled = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "nightfox"
    end
  }
}
