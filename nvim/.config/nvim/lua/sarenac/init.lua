require("sarenac.remap")
require("sarenac.set")

-- for stuff I'm currently not sure where to pu
vim.keymap.set("n", "<leader>bp", "aimport pdb; pdb.set_trace()<Esc>")
vim.keymap.set("n", "<leader>ci", "aimport code; code.interact(local=locals())<Esc>")

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
