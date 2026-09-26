-- and lsp also
local function gh(x)
    return "https://github.com/" .. x
end

vim.pack.add({
    gh("folke/lazydev.nvim"),
    gh("rose-pine/neovim"),
    gh("mason-org/mason.nvim"),
    gh("stevearc/oil.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("tpope/vim-dadbod"),
    gh("kristijanhusak/vim-dadbod-ui"),
    gh("kristijanhusak/vim-dadbod-completion"),
    gh("stevearc/conform.nvim"),
    gh("lervag/vimtex"),
    gh("neovim/nvim-lspconfig"),
    gh("3rd/image.nvim"),
    gh("chomosuke/typst-preview.nvim"),
})

-- On-demand plugins, not loaded until ":packadd ...".
vim.pack.add({ "https://github.com/NvChad/showkeys" }, { load = function() end })
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")

require("lazydev").setup({})
require("mason").setup()

-- from my package manager
vim.lsp.config("qmlls", {
    cmd = {
        "qmlls6",
        "-I",
        "/usr/lib/qt6/qml",
    },
})

vim.lsp.enable({
    "clangd",
    "lua_ls",
    "jdtls",
    "ty",
    "ts_ls",
    "rust_analyzer",
    "zls",
    "qmlls",
    "tinymist",
})

require("rose-pine").setup({
    styles = {
        italic = true,
        transparency = true
    }
})
vim.cmd("colorscheme rose-pine")
vim.api.nvim_set_hl(0, "StatusLineTerm", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "StatusLineTermNC", { link = "StatusLineNC" })

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

require("conform").setup({
    formatters_by_ft = {
        html = { "prettier" },
        json = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        python = { "black" },
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
        qml = { "qmlformat" },
    }
})
vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

require("image").setup()
require("typst-preview").setup()
