-- Global options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.editorconfig = true

-- Other options
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = -1
opt.tabstop = 4
opt.winborder = "rounded"
opt.signcolumn = "yes"
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " ", vert = "│" }
opt.splitbelow = true
opt.undofile = true
opt.mouse = ""

vim.pack.add({
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/rose-pine/neovim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/tpope/vim-dadbod",
    "https://github.com/kristijanhusak/vim-dadbod-ui",
    "https://github.com/kristijanhusak/vim-dadbod-completion",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/lervag/vimtex",
    "https://github.com/neovim/nvim-lspconfig",
})

-- On-demand plugins, not loaded until ":packadd ...".
vim.pack.add({ "https://github.com/NvChad/showkeys" }, { load = function() end })

vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")

-- Plugin setup
require("lazydev").setup({})
require("mason").setup()

vim.lsp.enable({ "clangd" , "lua_ls" , "jdtls" , "ty", "ts_ls", "rust_analyzer", "zls" })

require("rose-pine").setup({
    styles = {
        italic = true,
        transparency = true
    }
})
vim.cmd("colorscheme rose-pine")

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
        lua = { "stylua" }
    }
})
opt.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Keymaps
local map = vim.keymap.set

map("n", "-", "<cmd>Oil<CR>", { desc = "File explorer" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste system clipboard" })
map("n", "<leader>u", "<cmd>Undotree<CR>", { desc = "Undotree" })
map("n", "<leader>tb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>t/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Buffer Fuzzy Find" })
map("n", "<leader>tf", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>tg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>th", "<cmd>Telescope help_tags<CR>", { desc = "Help" })

map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")
