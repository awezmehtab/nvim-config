local map = vim.keymap.set

map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>t", "<cmd>sp term://zsh<CR>", { desc = "Terminal" })
map({"n", "v"}, "<leader>y", "\"+y", { desc = "Copy system clipboard" })
map({"n", "v"}, "<leader>p", "\"+p", { desc = "Paste system clipboard" })

map("t", "<C-w>h", "<C-\\><C-n><C-w>h")
map("t", "<C-w>j", "<C-\\><C-n><C-w>j")
map("t", "<C-w>k", "<C-\\><C-n><C-w>k")
map("t", "<C-w>l", "<C-\\><C-n><C-w>l")

