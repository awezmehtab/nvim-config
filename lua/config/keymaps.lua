vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>x", ":luafile %<CR>", { desc = "Load this file into nvim instance" })

local lsp_dir = vim.fn.stdpath("config") .. "/lsp"

local function lsp_picker()
    local items = {}
    for _, p in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", false, true)) do
        items[#items + 1] = vim.fn.fnamemodify(p, ":t:r")
    end

    vim.ui.select(items, {
        prompt = "Enable LSP",
        -- optional, only if telescope-ui-select is installed
        telescope = require("telescope.themes").get_ivy(),
    }, function(choice)
        if not choice then return end
        vim.lsp.enable(choice)
        print("Enabled " .. choice)
    end)
end

vim.keymap.set("n", "<leader>sl", lsp_picker, { desc = "LSP picker" })
