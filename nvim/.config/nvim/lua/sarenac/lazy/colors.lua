return {
  -- "whatyouhide/vim-gotham",
  -- config = function ()
  --     vim.cmd.colorscheme("gotham")
  -- end
  "miikanissi/modus-themes.nvim",
  priority = 1000,
  config = function()
    require("modus-themes").setup({
      variant = "default", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
      dim_inactive = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false }
      }
    })
    vim.cmd.colorscheme("modus_vivendi") -- modus_operandi, modus_vivendi
  end
}
