require("options")

vim.pack.add {
	"https://github.com/rose-pine/neovim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/folke/lazydev.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
    "https://github.com/kristijanhusak/vim-dadbod-completion",
}


require("rose-pine").setup({
    styles = {
        -- italic = false,
        transparency = true
    }
})
vim.cmd("colorscheme rose-pine")

require("mason").setup()
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
    use_default_keymaps = true,
    delete_to_trash = true,
    watch_for_changes = true,
    constrain_cursor = false,
})
require("telescope").setup({})
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

vim.lsp.enable({ "clangd" , "lua_ls" , "jdtls" , "ty" })

require("keymaps")
