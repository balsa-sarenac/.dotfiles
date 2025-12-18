return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "L3MON4D3/LuaSnip",
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
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
          ensure_installed = {
              "lua_ls",
              "ty",
              "ruff",
          },
          handlers = {
              function(server_name) -- default handler (optional)
                  require("lspconfig")[server_name].setup {
                      capabilities = capabilities
                  }
              end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "Lua 5.1" },
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          })
        end,
        ["ty"] = function()
          lspconfig.ty.setup({
            capabilities = capabilities,
          })
        end
      }
    })
    vim.lsp.config('ty', {
      settings = {
        ty = {
          -- ty language server settings go here
        }
      }
    })
    vim.lsp.enable('ty')

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    vim.keymap.set("n", "<Space>f", function() vim.lsp.buf.format() end)
  end
}
