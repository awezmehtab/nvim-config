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
map("n", "<leader>tp", "<cmd>TypstPreview<CR>", { desc = "Typst preview" })
map("n", "<leader>ti", function()
    local image = require("image")
    if image.is_enabled() then
        image.disable()
    else
        image.enable()
    end
end, { desc = "Toggle inline images" })
map("n", "<leader>tn", function()
    local name = vim.fn.input("Tab name: ")
    if name ~= "" then
        vim.t.tabname = name
        vim.cmd.redrawtabline()
    end
end, { desc = "Rename tab" })

map("n", "<C-Tab>", "<cmd>tabnext<CR>")
map("n", "<C-S-Tab>", "<cmd>tabprevious<CR>")
map("t", "<C-Tab>", "<C-\\><C-n><cmd>tabnext<CR>")
map("t", "<C-S-Tab>", "<C-\\><C-n><cmd>tabprevious<CR>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

map("t", "<C-f>", "<PageDown>")
map("t", "<C-b>", "<PageUp>")

local term = require("my.term")
map({ "t", "i", "v", "n", "x" }, "<C-s>", term.toggle)
