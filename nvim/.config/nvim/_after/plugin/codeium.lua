
vim.g.codeium_filetypes = {
    ["tex"] = false,
}

vim.keymap.del('i', '<Tab>')
vim.keymap.set('i', '<Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
