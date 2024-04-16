return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require('rose-pine').setup({
            disable_background = true,
            styles = {
                italic = false,
            },
            --- @usage 'auto'|'main'|'moon'|'dawn'
            variant = 'dawn',
            --- @usage 'main'|'moon'|'dawn'
            dark_variant = 'main',
        })

        vim.cmd.colorscheme("rose-pine")

    end
}
