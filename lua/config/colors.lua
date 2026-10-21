vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
})
require("kanagawa").setup({
    overrides = function(colors)
        local ui = colors.theme.ui
        return {
            StatusLine = { fg = ui.fg_dim, bg = ui.bg },
            StatusLineNC = { fg = ui.nontext, bg = ui.bg },
        }
    end,
})
vim.cmd("colorscheme kanagawa-dragon")
