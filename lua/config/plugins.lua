-- and lsp also
local function gh(x)
    return "https://github.com/" .. x
end

vim.pack.add({
    gh("folke/lazydev.nvim"),
    gh("mason-org/mason.nvim"),
    gh("stevearc/oil.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("ibhagwan/fzf-lua"),
    gh("tpope/vim-dadbod"),
    gh("kristijanhusak/vim-dadbod-ui"),
    gh("kristijanhusak/vim-dadbod-completion"),
    gh("stevearc/conform.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("3rd/image.nvim"),
    gh("chomosuke/typst-preview.nvim"),
    gh("tpope/vim-fugitive"),
    gh("kokusenz/deltaview.nvim"),
    gh("nvim-treesitter/nvim-treesitter"),
})

-- not loaded until ":packadd ..."
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

require("oil").setup({
    keymaps = {
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["gm"] = {
            desc = "Toggle cursor lock to filename",
            callback = function()
                local cfg = require("oil.config")
                if cfg.constrain_cursor then
                    cfg.constrain_cursor = false
                else
                    cfg.constrain_cursor = "name"
                end
            end,
        },
    },
    columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
    },
    view_options = {
        show_hidden = true,
    },
    delete_to_trash = true,
    watch_for_changes = true,
    constrain_cursor = "name",
    preview_win = { preview_method = "load" },
})

require("fzf-lua").setup({
    buffers = { fzf_opts = { ["--header-lines"] = false } },
})

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

require("image").setup({ max_height_window_percentage = 100 })
require("deltaview").setup()

vim.api.nvim_create_autocmd("FileType", {
    callback = function() pcall(vim.treesitter.start) end,
})
