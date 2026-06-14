return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  branch = "main",
  config = function()
    local treesitter = require("nvim-treesitter")
    local parsers = {
      "vimdoc",
      "javascript",
      "typescript",
      "lua",
      "python",
      "bash",
      "latex",
      "bibtex",
      "markdown",
      "markdown_inline",
    }

    treesitter.setup()

    vim.schedule(function()
      local installed = {}
      for _, parser in ipairs(treesitter.get_installed("parsers")) do
        installed[parser] = true
      end

      local missing = {}
      for _, parser in ipairs(parsers) do
        if not installed[parser] then
          missing[#missing + 1] = parser
        end
      end

      if #missing > 0 then
        treesitter.install(missing)
      end
    end)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("sarenac_treesitter", { clear = true }),
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end
}
