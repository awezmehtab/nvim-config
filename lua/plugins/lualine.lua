return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = require("extras.lualine-theme").theme(),
                    section_separators = "",
                    component_separators = "",
                },
                sections = {
                    lualine_c = {
                        { "filename", path = 1 }, -- full path
                    },
                    lualine_x = { "encoding", { "fileformat", symbols = { unix = "󰣇" } }, "filetype" },
                },
                extensions = { "toggleterm" },
            })
        end,
    },
}
