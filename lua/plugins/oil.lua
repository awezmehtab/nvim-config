return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
                view_options = {
                    show_hidden = true,
                },
                -- this makes devicons use their filetype colors
                use_default_keymaps = true,
                delete_to_trash = true,
                watch_for_changes = true,
                constrain_cursor = false,
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Floating oil" })
        end,
    },
}
