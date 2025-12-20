return {
    -- amongst your other plugins
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<C-t>]],
            })
        end,
    },
    -- or
}
