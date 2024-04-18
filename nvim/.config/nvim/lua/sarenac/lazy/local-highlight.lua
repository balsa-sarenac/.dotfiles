return {
    "tzachar/local-highlight.nvim",
    config = function()
        require("local-highlight").setup({
            file_types = {}, -- If this is given only attach to this
            disable_file_types = {},
            hlgroup = 'Visual',
            cw_hlgroup = nil,
            insert_mode = false,
            min_match_len = 1,
            max_match_len = math.huge,
        })
    end
}
