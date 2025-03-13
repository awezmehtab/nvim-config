return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            styles = {
                transparency = true,
            },
            highlight_groups = {
                WinSeparator = { fg = "#000000", bg = "#000000" },
            },
        })
        vim.cmd("colorscheme rose-pine")
    end,
}
