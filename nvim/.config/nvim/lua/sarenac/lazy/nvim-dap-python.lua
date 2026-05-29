return {
  'mfussenegger/nvim-dap-python',
  config = function()
    local dap_python = require("dap-python")
    dap_python.setup(vim.fn.exepath('python3'))

    vim.keymap.set("n", "<leader>dn", function() dap_python.test_method() end)
    vim.keymap.set("n", "<leader>df", function() dap_python.test_class() end)
    vim.keymap.set("v", "<leader>ds", function() dap_python.debug_selection() end)
  end
}
