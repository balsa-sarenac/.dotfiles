return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim",
    "saghen/blink.cmp",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        }
      }
    }
  },

  config = function()
    require("fidget").setup({})

    vim.lsp.config('*', {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = "Lua 5.1" },
          diagnostics = {
            globals = { "vim", "it", "describe", "before_each", "after_each" },
          }
        }
      }
    })

    vim.lsp.enable({ 'lua_ls', 'ty', 'ruff' })

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

  end
}
