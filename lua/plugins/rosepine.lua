return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            styles = {
                transparency = true,
            },
        })

        vim.cmd("colorscheme rose-pine")
        vim.opt.fillchars:append({ vert = " " })

        -- sadly rosepine terminal status line is different, which I hate
        vim.api.nvim_set_hl(0, "StatusLineTerm", { link = "StatusLine" })
        vim.api.nvim_set_hl(0, "StatusLineTermNC", { link = "StatusLineNC" })
    end,
}
