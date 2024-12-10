return {
  "sindrets/diffview.nvim",
  config = function()
    local diffview = require("diffview")
    diffview.setup({
      use_icons = false,
    })
  end
}
